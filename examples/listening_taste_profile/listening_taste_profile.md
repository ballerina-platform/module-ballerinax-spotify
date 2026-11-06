# Listening taste profile

This example builds a listening taste profile for the signed-in Spotify user. It reads the user's profile, lists their top artists and top tracks for a chosen time range, and summarises their favourite genres from the top artists.

## Prerequisites

### 1. Set up a Spotify app

Follow the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-spotify/blob/main/ballerina/README.md#setup-guide) to obtain a client ID, client secret and refresh token. The refresh token must be granted the `user-top-read` and `user-read-private` scopes.

### 2. Configuration

Create a `Config.toml` file in this example's directory with the following content:

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
timeRange = "<short_term, medium_term or long_term>"
topCount = 10
```

## Run the example

Execute the following command to run the example:

```bash
bal run
```
