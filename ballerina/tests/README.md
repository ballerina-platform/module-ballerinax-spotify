# Running Tests

## Prerequisites

To run the tests against the live Spotify Web API you need:

- An OAuth 2.0 access token from your [Spotify Developer account](https://developer.spotify.com/dashboard), exposed as `SPOTIFY_ACCESS_TOKEN`.

## Running the tests

By default the tests run against a mock server that starts automatically with `bal test`:

```bash
bal test
```

To run them against the live API, set `IS_LIVE_SERVER` and the credentials above:

```bash
IS_LIVE_SERVER=true SPOTIFY_ACCESS_TOKEN=<token> bal test
```

Tests that modify data (creating playlists, saving or removing tracks, and similar) are skipped against the live API.
