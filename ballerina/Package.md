## Overview

[Spotify](https://www.spotify.com/) is a popular music streaming service that allows users to listen to millions of songs, podcasts, and other audio content from artists and creators worldwide. It offers personalized playlists, radio stations, and social features, enabling users to discover new music and share content with friends.

The `ballerinax/spotify` package provides APIs to connect and interact with Spotify Web API endpoints, which allow access to Spotify's catalog, user data, and playback features. This package enables developers to integrate Spotify functionalities, such as searching for tracks, managing playlists, and controlling playback, into their applications.

## Setup guide

To use the Spotify connector, you must have access to the Spotify API through a [Spotify developer account](https://developer.spotify.com) and a project under it. If you do not have a Spotify Developer account, you can sign up for one [here](https://developer.spotify.com/documentation/web-api/concepts/access-token).

### Step 1: Create a Spotify Developer Project

1. Open the [Spotify Developer Portal](https://developer.spotify.com/dashboard).

2. Click on the "Create an app" tab and select an existing project or create a new one for which you want API Keys and Authentication Tokens.


### Step 2: Set up user authentication settings

Enter an App Name and App Description of your choice (they will be displayed to the user on the grant screen), put a tick in the Developer Terms of Service checkbox and finally click on CREATE. Your application is now registered, and you'll be redirected to the app overview page.

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
  "access_token": <Access Token>,
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
