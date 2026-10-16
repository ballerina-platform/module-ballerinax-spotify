_Author_:  @Sachindu-Nethmin\
_Created_: 2024/10/22\
_Updated_: 2026/10/16 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Spotify. 
The OpenAPI specification is obtained from the [Spotify OpenAPI Documentation](https://developer.spotify.com/reference/web-api/open-api-schema.yaml).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. **Removed the `x-spotify-policy` vendor extension** (made in the original spec, `docs/spec/openapi.yaml`). `components.x-spotify-policy.policies` was a `$ref` to an external `../policies.yaml` that is not distributed with the spec, so the spec was not self-contained. Dropped the `components.x-spotify-policy` block and all 45 `x-spotify-policy-list` entries that referenced it (on operations and on the `preview_url` properties). The metadata is informational only and has no effect on the generated client.

2. **Removed the `example` from the `PUT /playlists/{playlist_id}/images` request body schema** (made in the original spec, `docs/spec/openapi.yaml`). The base64 JPEG sample string was re-serialized by `bal openapi align` as a YAML `!!binary` value, which cannot be converted to JSON.

3. **Promoted 16 inline response schemas to named `components.schemas` entries** (made in the original spec, `docs/spec/openapi.yaml`). The inline object schemas in `components.responses` (`ManyAlbums`, `ManyAudiobooks`, `ManyChapters`, `ManyDevices`, `PagedAlbums`, `PagedCategories`, `CursorPagedArtists`, `ManyArtists`, `ManyAudioFeatures`, `ManyEpisodes`, `ManyGenres`, `ManyTracks`, `ManySimplifiedShows`, `SearchItems`, `PlaylistSnapshotId`, `PagingArtistOrTrackObject`) were not extracted by flatten and produced `inline_response_200_N` types. They are now the schemas `AlbumsResponse`, `AudiobooksResponse`, `ChaptersResponse`, `DevicesResponse`, `NewReleasesResponse`, `CategoriesResponse`, `FollowedArtistsResponse`, `ArtistsResponse`, `AudioFeaturesListResponse`, `EpisodesResponse`, `GenresResponse`, `TracksResponse`, `ShowsResponse`, `SearchResultsResponse` `PlaylistSnapshotResponse` and `PagingArtistOrTrackResponse`, with descriptions added, and the responses reference them.

4. **Simplified `info.description`** (made in the original spec, `docs/spec/openapi.yaml`). The vendor text described Spotify's documentation website (sidebar navigation, guide and forum links) and became the generated `Client` doc comment. It is replaced with a short summary of what the client covers and the OAuth 2.0 requirement.

5. **Removed every deprecated operation** (made in the original spec, `docs/spec/openapi.yaml`). The 48 operations marked `deprecated: true` were dropped, together with the 31 path items they left empty and the 50 components (26 schemas, 18 responses, 6 parameters) that became unreferenced. Removed operations (final operationIds): `addTracksToPlaylist`, `checkFollowing`, `checkPlaylistFollowers`, `checkSavedAlbums`, `checkSavedAudiobooks`, `checkSavedEpisodes`, `checkSavedShows`, `checkSavedTracks`, `createUserPlaylist`, `followArtistsOrUsers`, `followPlaylist`, `getAudioAnalysis`, `getAudioFeatures`, `getCategory`, `getRecommendations`, `getUserProfile`, `listAlbums`, `listArtistTopTracks`, `listArtists`, `listAudioFeatures`, `listAudiobooks`, `listCategories`, `listCategoryPlaylists`, `listChapters`, `listEpisodes`, `listFeaturedPlaylists`, `listGenreSeeds`, `listMarkets`, `listNewReleases`, `listPlaylistTracks`, `listRelatedArtists`, `listShows`, `listTracks`, `listUserPlaylists`, `removePlaylistTracks`, `removeSavedAlbums`, `removeSavedAudiobooks`, `removeSavedEpisodes`, `removeSavedShows`, `removeSavedTracks`, `saveAlbums`, `saveAudiobooks`, `saveEpisodes`, `saveShows`, `saveTracks`, `unfollowArtistsOrUsers`, `unfollowPlaylist`, `updatePlaylistTracks`.

   The removal was made with [`resources/prune_deprecated.py`](resources/prune_deprecated.py). To reproduce it on a fresh copy of the vendor spec, run the script from the repository root **before** the generating-connectors skill (and after re-applying items 1–4):

   ```bash
   python3 docs/spec/resources/prune_deprecated.py --repo . --dry-run   # review what goes
   python3 docs/spec/resources/prune_deprecated.py --repo .             # apply
   ```

   The script is idempotent: on the committed spec it finds nothing to remove. Removing operations changes flatten's numbering of generated request-body schemas (`PlaylistIdItemsBody`, `PlaylistIdItemsBody1`, …). After a prune, check that the `*Body` names in `ai-mappings.json` still map to the intended schemas, or redo those schema names, so that regeneration keeps the same public type names.

6. **Added descriptions to undocumented path parameters and `$ref` properties** (made in the original spec, `docs/spec/openapi.yaml`). The path parameters `PathAlbumId`, `PathArtistId`, `PathShowId`, `PathAudiobookId`, `PathChapterId` and `PathPlaylistId`, and the inline `id` path parameters of `GET /episodes/{id}` and `GET /tracks/{id}` and `type` of `GET /me/top/{type}`, had their description only on the `schema`, which the generated client does not document. Each now has a parameter-level `description`. The bare `$ref` properties of `FollowedArtistsResponse` (`artists`) and `SearchResultsResponse` (`tracks`, `artists`, `albums`, `playlists`, `shows`, `episodes`, `audiobooks`) are wrapped as `allOf: [$ref]` with a `description`, because a description beside a `$ref` is dropped.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json -o ballerina --mode client --license docs/license.txt --client-methods remote
```

Note: The license year is hardcoded to 2024, change if necessary.
