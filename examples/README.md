# Examples

The `ballerinax/spotify` connector provides practical examples illustrating usage in various scenarios.

1. **[Listening taste profile](https://github.com/ballerina-platform/module-ballerinax-spotify/tree/main/examples/listening_taste_profile)** - Summarise the signed-in user's top artists, top tracks and favourite genres.

2. **[Top tracks playlist builder](https://github.com/ballerina-platform/module-ballerinax-spotify/tree/main/examples/top_tracks_playlist_builder)** - Turn the user's top tracks into a new playlist.

## Prerequisites

1. Generate Spotify credentials to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/spotify/latest#setup-guide).

2. For each example, create a `Config.toml` file with the related configuration. Here's an example of how your `Config.toml` file should look:

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
```

Each example lists the additional values it needs in its own README.

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```
