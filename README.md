# Ballerina Spotify connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-spotify/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-spotify/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-spotify.svg)](https://github.com/ballerina-platform/module-ballerinax-spotify/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/spotify.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fspotify)

## Overview

[Spotify](https://www.spotify.com/) is a music and podcast streaming service that gives listeners access to millions of tracks, albums, podcasts, and audiobooks, along with personalised playlists and recommendations.

The Spotify connector provides a Ballerina client for the [Spotify Web API](https://developer.spotify.com/documentation/web-api). It lets you search the Spotify catalogue, read and manage a user's library and playlists, follow artists and users, and inspect and control playback on a user's devices from your integrations.

## Setup guide

To use the Spotify connector, you need a Spotify account and an app registered in the Spotify Developer Dashboard.

### Step 1: Create a Spotify app

1. Sign in to the [Spotify Developer Dashboard](https://developer.spotify.com/dashboard) and select **Create app**.
2. Enter an app name and description, add a redirect URI such as `http://127.0.0.1:8080/callback`, select the **Web API** option, accept the terms of service, and save the app.
3. Open the app's **Settings** page and note the **Client ID** and **Client secret**.

### Step 2: Obtain a refresh token

1. Open the authorization URL in a browser, replacing the placeholders. Request the scopes your integration needs, for example `user-read-private playlist-modify-private user-top-read user-library-read`.

   ```
   https://accounts.spotify.com/authorize?client_id=<client-id>&response_type=code&redirect_uri=<redirect-uri>&scope=<space-separated-scopes>
   ```

2. Approve the request. Spotify redirects to your redirect URI with a `code` query parameter.
3. Exchange the code for tokens.

   ```bash
   curl -X POST "https://accounts.spotify.com/api/token" \
     -H "Authorization: Basic <base64 of client-id:client-secret>" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "grant_type=authorization_code&code=<code>&redirect_uri=<redirect-uri>"
   ```

4. Copy the `refresh_token` from the response. The connector uses it to obtain new access tokens automatically.

> **Note**: Endpoints that read or change user data need a token granted by that user through this flow. Alternatively, a short-lived access token can be passed with the `token` field of the connector's bearer-token configuration.

## Quickstart

To use the Spotify connector in your Ballerina application, modify the `.bal` file as follows.

#### Step 1: Import the connector

```ballerina
import ballerinax/spotify;
```

#### Step 2: Create a new connector instance

Create a `Config.toml` file with your credentials.

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
```

Then create a client from them.

```ballerina
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

spotify:Client spotify = check new ({
    auth: {clientId, clientSecret, refreshToken}
});
```

#### Step 3: Invoke the connector operation

Fetch a track from the Spotify catalogue.

```ballerina
public function main() returns error? {
    spotify:TrackObject _ = check spotify->getTrack("2Foc5Q5nqNiosCNqttzHof");
}
```

#### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `Spotify` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-spotify/tree/main/examples/), covering the following use cases:

- [Listening taste profile](examples/listening_taste_profile/listening_taste_profile.md) - Summarise the signed-in user's top artists, top tracks, and favourite genres.
- [Top tracks playlist builder](examples/top_tracks_playlist_builder/top_tracks_playlist_builder.md) - Turn the user's top tracks into a new playlist.

## Build from source

### Setting up prerequisites

1. Download and install Java SE Development Kit (JDK) version 21 from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where the JDK is installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export a GitHub Personal Access Token with read package permissions as follows:

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal Access Token>
    ```

### Build options

Run the following commands to build from source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`spotify` package](https://central.ballerina.io/ballerinax/spotify/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
