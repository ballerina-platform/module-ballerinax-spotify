# Top tracks playlist builder

This example turns the signed-in Spotify user's top tracks into a playlist. It reads the top tracks for a chosen time range, creates a private playlist and adds the tracks to it. Nothing is created unless `createPlaylist` is set to `true`, so the example can be run safely as a dry run.

## Prerequisites

### 1. Set up a Spotify app

Follow the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-spotify/blob/main/ballerina/README.md#setup-guide) to obtain a client ID, client secret and refresh token. The refresh token must be granted the `user-top-read` and `playlist-modify-private` scopes.

### 2. Configuration

Create a `Config.toml` file in this example's directory with the following content:

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
playlistName = "<playlist-name>"
timeRange = "<short_term, medium_term or long_term>"
trackCount = 20
createPlaylist = false
```

## Run the example

Execute the following command to run the example:

```bash
bal run
```
