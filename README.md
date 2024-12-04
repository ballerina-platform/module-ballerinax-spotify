# Ballerina Spotify connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-spotify/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-spotify/actions/workflows/ci.yml)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-spotify/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-spotify/actions/workflows/trivy-scan.yml)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-spotify/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-spotify/actions/workflows/build-with-bal-test-graalvm.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-spotify.svg)](https://github.com/ballerina-platform/module-ballerinax-spotify/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/spotify.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%spotify)

## Overview

[Spotify](https://www.spotify.com/) is a popular music streaming service that allows users to listen to millions of songs, podcasts, and other audio content from artists and creators worldwide. It offers personalized playlists, radio stations, and social features, enabling users to discover new music and share content with friends.

The `ballerinax/spotify` package provides APIs to connect and interact with Spotify Web API endpoints, which allow access to Spotify's catalog, user data, and playback features. This package enables developers to integrate Spotify functionalities, such as searching for tracks, managing playlists, and controlling playback, into their applications.

## Setup guide

To use the Spotify connector, you must have access to the Spotify API through a [Spotify developer account](https://developer.spotify.com) and a project under it. If you do not have a Spotify Developer account, you can sign up for one [here](https://developer.spotify.com/documentation/web-api/concepts/access-token).

### Step 1: Create a Spotify Developer Project

1. Open the [Spotify Developer Portal](https://developer.spotify.com/dashboard).

2. Click on the "Create an app" tab and select an existing project or create a new one for which you want API Keys and Authentication Tokens.


### Step 2: Set up user authentication settings


Enter an App Name and App Description of your choice (they   will be displayed to the user on the grant screen), put a tick in the Developer Terms of Service checkbox and finally click on CREATE. Your application is now registered, and you'll be redirected to the app overview page.

### Step 3. Obtain Client Id and Client Secret.

With our credentials in hand, we are ready to request an access token.

1. Send a POST request to the token endpoint URI.
2. Add the Content-Type header set to the application/x-www-form-urlencoded value.
3. Add a HTTP body containing the Client ID and Client Secret, along with the grant_type parameter set to client_credentials.

```bash
    curl -X POST "https://accounts.spotify.com/api/token" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "grant_type=client_credentials&client_id=your-client-id&client_secret=your-client-secret"
```
The response will return an access token valid for 1 hour
```
{
  "access_token": "BQDBKJ5eo5jxbtpWjVOj7ryS84khybFpP_lTqzV7uV-T_m0cTfwvdn5BnBSKPxKgEb11",
  "token_type": "Bearer",
  "expires_in": 3600
}
```

## Quickstart

To use the `spotify` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

Import the `spotify` module.

```ballerina
import ballerinax/spotify;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and, configure the obtained credentials in the above steps as follows:

```bash
token = "<Access Token>"
```

2. Create a `spotify:ConnectionConfig` with the obtained access token and initialize the connector with it.

```ballerina
configurable string token = ?;

final spotify:Client spotify = check new({
    auth: {
        token
    }
});
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `Spotify` connector provides practical examples illustrating usage in various scenarios. 

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 17. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

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
