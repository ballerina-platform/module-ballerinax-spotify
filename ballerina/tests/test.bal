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
isolated function getAlbumTest() returns error? {
    AlbumObject response = check spotify->/albums/[albumId];
    test:assertTrue(response is AlbumObject);
}

@test:Config {}
isolated function getArtistTest() returns error? {
    ArtistObject response = check spotify->/artists/[artistId];
    test:assertTrue(response is ArtistObject);
}

@test:Config {}
isolated function getAudiobooksTest() returns error? {
    AudiobookObject response = check spotify->/audiobooks/ [audiobooksId];
    test:assertTrue(response is AudiobookObject);
}

@test:Config {}
isolated function browseCategoriesTest() returns error? {
    PagedCategoriesObject response = check spotify->/browse/categories;
    test:assertTrue(response is PagedCategoriesObject);
}

@test:Config {}
isolated function getChaptersTest() returns error? {
    AudiobookObject response = check spotify->/chapters/[chaptersId];
    test:assertTrue(response is AudiobookObject);
}

@test:Config {}
isolated function getEpisodeTest() returns error? {
    EpisodeObject response = check spotify->/episodes/[episodeId];
    test:assertTrue(response is EpisodeObject);
}

@test:Config {}
isolated function getMarketsTest() returns error? {
    MarketsResponse response = check spotify->/markets;
    test:assertTrue(response is MarketsResponse);
}

@test:Config {}
isolated function getplaylistTest() returns error? {
    CurrentlyPlayingContextObject response = check spotify->/playlists/[playlistsId];
    test:assertTrue(response is CurrentlyPlayingContextObject);
}

@test:Config {}
isolated function getShowsTest() returns error? {
    CurrentlyPlayingContextObject response = check spotify->/shows/[showsId];
    test:assertTrue(response is CurrentlyPlayingContextObject);
}

@test:Config {}
isolated function getTrackTest() returns error? {
    TrackObject response = check spotify->/tracks/[tracksId];
    test:assertTrue(response is TrackObject);
}

@test:Config {}
isolated function getUserTest() returns error? {
    PrivateUserObject response = check spotify->/tracks/[tracksId];
    test:assertTrue(response is PrivateUserObject);
}

@test:Config {}
isolated function getAlbumTracksTest() returns error? {
    PagingSimplifiedTrackObject response = check spotify->/albums/[albumId ]/tracks;
    test:assertTrue(response is PagingSimplifiedTrackObject);
}

@test:Config {}
isolated function getArtistIdTest() returns error? {
    ArtistObject response = check spotify->/artists/[artistId];
    test:assertTrue(response is ArtistObject);
}

@test:Config {}
isolated function getArtistsAlbumTest() returns error? {
    PagingArtistDiscographyAlbumObject response = check spotify->/artists/[artistId]/albums;
    test:assertTrue(response is PagingArtistDiscographyAlbumObject);
}

@test:Config {}
isolated function browseCategoryTest() returns error? {
    CategoryObject response = check spotify->/browse/categories/[categoryId];
    test:assertTrue(response is CategoryObject);
}
