#!/usr/bin/env python3
"""
Remove every deprecated operation from a connector's original spec, and the components it orphans.

Run this against the ORIGINAL spec (`docs/spec/openapi.*`), before the generating-connectors
skill aligns it, so flatten, align and generation carry the removal everywhere after. Record the
run as one numbered item in `docs/spec/sanitations.md`; the report's `removed_operations` is the
list that item names.

    python3 prune_deprecated.py --repo module-ballerinax-foo --dry-run      # what would go
    python3 prune_deprecated.py --repo module-ballerinax-foo                # apply
    python3 prune_deprecated.py --spec path/to/openapi.yaml --json

What goes:
  * every operation with `deprecated: true`;
  * a path item left with no operations (its path-level `parameters`, `summary`, … with it);
  * entries of `components.schemas`, `responses`, `parameters`, `requestBodies`, `headers`,
    `examples` and `links` that no longer reach from anything kept, following `$ref` chains and
    discriminator `mapping` values to a fixed point. `securitySchemes`, top-level `security`,
    `tags`, `servers` and every `x-` extension stay as they are;
  * a components section left empty.

Formatting: YAML is edited in place line by line from PyYAML's node positions, so every kept line
stays byte-identical (comments and blank lines directly above a kept key stay with it). JSON is
re-dumped only when a round trip reproduces the file byte for byte (else it refuses). Either way
the written file is re-parsed and data-compared with the expected pruned document; any difference
refuses and writes nothing.

Exit codes: 0 done (or nothing to remove), 1 refused or failed, 2 bad arguments.
"""

from __future__ import annotations

import argparse
import copy
import json
import sys
from pathlib import Path

import yaml

METHODS = ("get", "put", "post", "delete", "patch", "head", "options", "trace")
PRUNABLE = ("schemas", "responses", "parameters", "requestBodies", "headers", "examples", "links")


class _Loader(yaml.SafeLoader):
    """SafeLoader without the timestamp resolver, so unquoted dates stay strings."""


_Loader.yaml_implicit_resolvers = {
    k: [r for r in v if r[0] != "tag:yaml.org,2002:timestamp"]
    for k, v in yaml.SafeLoader.yaml_implicit_resolvers.items()}


# =============================================================================
# planning (format-independent)
# =============================================================================

def refs_in(node, out: set):
    """Collect every local `#/components/<section>/<name>` reached directly from `node`."""
    if isinstance(node, dict):
        for k, v in node.items():
            if k == "$ref" and isinstance(v, str):
                out.add(v)
            elif k == "mapping" and isinstance(v, dict):
                out.update(x for x in v.values() if isinstance(x, str))
            else:
                refs_in(v, out)
    elif isinstance(node, list):
        for x in node:
            refs_in(x, out)


def component_key(ref: str):
    parts = ref.split("/")
    if len(parts) >= 4 and parts[0] == "#" and parts[1] == "components":
        name = parts[3].replace("~1", "/").replace("~0", "~")
        return parts[2], name
    return None


def plan(spec: dict) -> dict:
    removed_ops, removed_paths, trimmed_paths = [], [], {}
    for path, item in (spec.get("paths") or {}).items():
        if not isinstance(item, dict):
            continue
        methods = [m for m in item if m in METHODS and isinstance(item[m], dict)]
        dep = [m for m in methods if item[m].get("deprecated") is True]
        if not dep:
            continue
        for m in dep:
            removed_ops.append({"operationId": item[m].get("operationId"),
                                "method": m.upper(), "path": path})
        if len(dep) == len(methods):
            removed_paths.append(path)
        else:
            trimmed_paths[path] = dep

    pruned = copy.deepcopy(spec)
    for path in removed_paths:
        del pruned["paths"][path]
    for path, dep in trimmed_paths.items():
        for m in dep:
            del pruned["paths"][path][m]

    comps = pruned.get("components") or {}
    # roots: everything except the prunable component sections
    seen, todo = set(), set()
    for k, v in pruned.items():
        if k != "components":
            refs_in(v, todo)
    for sect, v in comps.items():
        if sect not in PRUNABLE:
            refs_in(v, todo)
    while todo:
        ref = todo.pop()
        key = component_key(ref)
        if not key or key in seen:
            continue
        seen.add(key)
        sect, name = key
        target = (comps.get(sect) or {}).get(name)
        if target is not None:
            refs_in(target, todo)

    removed_components, removed_sections = {}, []
    for sect in PRUNABLE:
        entries = comps.get(sect)
        if not isinstance(entries, dict):
            continue
        gone = [n for n in entries if (sect, n) not in seen]
        if gone:
            removed_components[sect] = gone
            for n in gone:
                del entries[n]
            if not entries:
                del comps[sect]
                removed_sections.append(sect)
    if "components" in pruned and not comps:
        del pruned["components"]
        removed_sections.append("components")

    return {"removed_operations": removed_ops, "removed_paths": removed_paths,
            "trimmed_paths": trimmed_paths, "removed_components": removed_components,
            "removed_sections": removed_sections, "pruned": pruned}


# =============================================================================
# writers
# =============================================================================

def write_json(path: Path, text: str, p: dict) -> str:
    orig = json.loads(text)
    for indent in (2, 4):
        for ascii_ in (False, True):
            dumped = json.dumps(orig, indent=indent, ensure_ascii=ascii_)
            for tail in ("", "\n"):
                if dumped + tail == text:
                    return json.dumps(p["pruned"], indent=indent, ensure_ascii=ascii_) + tail
    raise SystemExit(f"refused: {path} does not round-trip byte for byte through json.dumps")


def write_yaml(text: str, p: dict) -> str:
    lines = text.splitlines(keepends=True)
    root = yaml.compose(text, Loader=_Loader)

    def find(node, key):
        if not isinstance(node, yaml.MappingNode):
            return None
        for i, (k, _) in enumerate(node.value):
            if k.value == key:
                return i
        return None

    def child(node, key):
        i = find(node, key)
        return None if i is None else node.value[i][1]

    def is_filler(n: int) -> bool:
        s = lines[n].strip()
        return not s or s.startswith("#")

    def pair_range(mnode, i):
        """[start, end) lines of the i-th pair; filler lines above the next key stay with it."""
        if mnode.flow_style:
            raise SystemExit(f"refused: flow-style mapping at line {mnode.start_mark.line + 1}")
        k, v = mnode.value[i]
        start = k.start_mark.line
        if i + 1 < len(mnode.value):
            end = mnode.value[i + 1][0].start_mark.line
        else:
            end = v.end_mark.line + (1 if v.end_mark.column > 0 else 0)
        end = min(end, len(lines))
        while end > start + 1 and is_filler(end - 1):
            end -= 1
        return start, end

    drop = []
    paths = child(root, "paths")
    for path in p["removed_paths"]:
        drop.append(pair_range(paths, find(paths, path)))
    for path, dep in p["trimmed_paths"].items():
        item = child(paths, path)
        for m in dep:
            drop.append(pair_range(item, find(item, m)))
    comps_i = find(root, "components")
    if "components" in p["removed_sections"]:
        drop.append(pair_range(root, comps_i))
    elif comps_i is not None:
        comps = root.value[comps_i][1]
        for sect, names in p["removed_components"].items():
            if sect in p["removed_sections"]:
                drop.append(pair_range(comps, find(comps, sect)))
                continue
            entries = child(comps, sect)
            for n in names:
                drop.append(pair_range(entries, find(entries, n)))

    gone = set()
    for s, e in drop:
        gone.update(range(s, e))
    return "".join(l for n, l in enumerate(lines) if n not in gone)


# =============================================================================
# main
# =============================================================================

def find_spec(repo: Path) -> Path:
    for ext in ("yaml", "yml", "json"):
        f = repo / "docs" / "spec" / f"openapi.{ext}"
        if f.exists():
            return f
    raise SystemExit(f"no docs/spec/openapi.{{yaml,yml,json}} under {repo}")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.strip().splitlines()[0])
    src = ap.add_mutually_exclusive_group(required=True)
    src.add_argument("--repo", type=Path, help="connector repo; uses docs/spec/openapi.*")
    src.add_argument("--spec", type=Path, help="original spec to prune")
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--json", action="store_true")
    args = ap.parse_args()

    path = args.spec or find_spec(args.repo)
    text = path.read_text(encoding="utf-8")
    is_json = path.suffix == ".json"
    spec = json.loads(text) if is_json else yaml.load(text, Loader=_Loader)
    p = plan(spec)

    report = {"spec": str(path),
              "operations": {"before": sum(1 for it in spec.get("paths", {}).values()
                                           if isinstance(it, dict) for m in it if m in METHODS),
                             "removed": len(p["removed_operations"])},
              "removed_operations": [o["operationId"] for o in p["removed_operations"]],
              "removed_paths": p["removed_paths"],
              "trimmed_paths": p["trimmed_paths"],
              "removed_components": p["removed_components"],
              "removed_sections": p["removed_sections"],
              "written": False}
    report["operations"]["after"] = report["operations"]["before"] - report["operations"]["removed"]

    if p["removed_operations"] and not args.dry_run:
        new = write_json(path, text, p) if is_json else write_yaml(text, p)
        check = json.loads(new) if is_json else yaml.load(new, Loader=_Loader)
        if check != p["pruned"]:
            raise SystemExit("refused: the edited file does not parse to the expected pruned "
                             "document; nothing written")
        path.write_text(new, encoding="utf-8")
        report["written"] = True

    if args.json:
        print(json.dumps(report, indent=2))
    else:
        ops = report["operations"]
        print(f"\n  {path}\n")
        print(f"    operations   {ops['before']} -> {ops['after']} ({ops['removed']} deprecated)")
        print(f"    paths        {len(p['removed_paths'])} removed, "
              f"{len(p['trimmed_paths'])} trimmed")
        for sect, names in p["removed_components"].items():
            print(f"    {sect:<12} {len(names)} orphaned: {', '.join(names)}")
        if p["removed_operations"]:
            print("    operationIds " + ", ".join(str(x) for x in report["removed_operations"]))
        print("\n    " + ("written" if report["written"] else
                          "dry run — nothing written" if args.dry_run else "nothing to remove"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
