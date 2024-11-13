// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/test;
import ballerina/log;

configurable string token = ?;

final string artistId = "0TnOYISbd1XYRBk9myaseg";
final string albumId = "4aawyAB9vmqN3uQ7FjRGTy";
final string audiobooksId = "7iHfbu1YPACw6oZPAFJtqe";
final string categoryId = "dinner";
final string episodeId = "512ojhOuo1ktJprKbVcKyQ";
final string chaptersId = "0D5wENdkdwbqlrHoaJ9g29";
final string playlistsId = "3cEYpjA9oz9GiPac4AsH4n";
final string showsId = "38bS44xjbVVZ3No3ByF1dJ";
final string tracksId = "11dFghVXANMlKmJXsNCbNl";
final string userId = "smedjan";

// Initialize the client with auth configuration
ConnectionConfig config = {
    auth: {
        token: token
    }
};

final Client spotify = check new(config);

@test:Config {}
function getAlbumTest() returns error? {
    
    AlbumObject|error response = spotify->/albums/[albumId];
    if response is error {
        log:printError("Failed to get album", response);
        test:assertFail("API call failed: " + response.message());
    }
    log:printInfo("Test passed: Successfully retrieved album data");
}

@test:Config {}
function getArtistTest() returns error? {

    ArtistObject|error response = check spotify->/artists/ [artistId];
    if response is error {
        log:printError("Failed to get artist", response);
        test:assertFail("API call failed: " + response.message());
    }
    log:printInfo("Test passed: Successfully retrieved artist data");
}

@test:Config {}
function getAudiobooksTest() returns error? {
    AudiobookObject|error response = check spotify->/audiobooks/ [audiobooksId];
    if response is error {
        log:printError("Failed to get Audiobooks", response);
        test:assertFail("API call failed: " + response.message());
    }
    log:printInfo("Test passed: Successfully retrieved Audiobooks data");
}

@test:Config {}
function browseCategoriesTest() returns error? {
    
    PagedCategoriesObject|error response = spotify->/browse/categories;
    if response is error {
        log:printError("Failed to get Browse Categories", response);
        test:assertFail("API call failed: " + response.message());
    }
    log:printInfo("Test passed: Successfully retrieved Browse Categories");
}

@test:Config {}
function getChaptersTest() returns error? {
    
    AudiobookObject|error response = spotify->/chapters/[chaptersId];
    if response is error {
        log:printError("Failed to get chapters", response);
        test:assertFail("API call failed: " + response.message());
    }
    log:printInfo("Test passed: Successfully retrieved chapters");
}

@test:Config {}
function getEpisodeTest() returns error? {
    
    EpisodeObject|error response = spotify->/episodes/[episodeId];
    if response is error {
        log:printError("Failed to get Episode", response);
        test:assertFail("API call failed: " + response.message());
    }
    log:printInfo("Test passed: Successfully retrieved Episode");
}

@test:Config {}
function getMarketsTest() returns error? {
    
    MarketsResponse|error response = spotify->/markets;
    if response is error {
        log:printError("Failed to get Markets", response);
        test:assertFail("API call failed: " + response.message());
    }
    log:printInfo("Test passed: Successfully retrieved Markets");
}

@test:Config {}
function getplaylistTest() returns error? {
    
    CurrentlyPlayingContextObject|error response = spotify->/playlists/[playlistsId];
    if response is error {
        log:printError("Failed to get playlist", response);
        test:assertFail("API call failed: " + response.message());
    }
    log:printInfo("Test passed: Successfully retrieved playlist");
}

@test:Config {}
function getShowsTest() returns error? {
    
    CurrentlyPlayingContextObject|error response = spotify->/shows/[showsId];
    if response is error {
        log:printError("Failed to get Shows", response);
        test:assertFail("API call failed: " + response.message());
    }
    log:printInfo("Test passed: Successfully retrieved Shows");
}

@test:Config {}
function getTrackTest() returns error? {
    
    TrackObject|error response = check spotify->/tracks/[tracksId];
    if response is error {
        log:printError("Failed to get Track", response);
        test:assertFail("API call failed: " + response.message());
    }
    log:printInfo("Test passed: Successfully retrieved Track data");
}

@test:Config {}
function getUserTest() returns error? {
    PrivateUserObject|error response = check spotify->/users/[userId];
    if response is error {
        log:printError("Failed to get  profile information about a Spotify user", response);
        test:assertFail("API call failed: " + response.message());
    }
    log:printInfo("Test passed: Successfully retrieved  profile information about a Spotify user data");
}

@test:Config {}
function getAlbumTracksTest() returns error? {
    
    PagingSimplifiedTrackObject|error response = spotify->/albums/[albumId ]/tracks;
    if response is error {
        log:printError("Failed to get album tracks", response);
        test:assertFail("API call failed: " + response.message());
    }
    log:printInfo("Test passed: Successfully retrieved album tracks");
}

@test:Config {}
function getArtistIdTest() returns error? {
    
    ArtistObject|error response = spotify->/artists/[artistId];
    if response is error {
        log:printError("Failed to get Artist by Id", response);
        test:assertFail("API call failed: " + response.message());
    }
    log:printInfo("Test passed: Successfully retrieved Artist by Id");
}

@test:Config {}
function getArtistsAlbumTest() returns error? {
    
    PagingArtistDiscographyAlbumObject|error response = spotify->/artists/[artistId]/albums;
    if response is error {
        log:printError("Failed to get Artist Album", response);
        test:assertFail("API call failed: " + response.message());
    }
    log:printInfo("Test passed: Successfully retrieved Artist Album");
}

@test:Config {}
function browseCategoryTest() returns error? {
    
    CategoryObject|error response = spotify->/browse/categories/[categoryId];
    if response is error {
        log:printError("Failed to get Browse Category", response);
        test:assertFail("API call failed: " + response.message());
    }
    log:printInfo("Test passed: Successfully retrieved Browse Category");
}
