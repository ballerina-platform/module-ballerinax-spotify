
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

import ballerina/http;
import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://api.spotify.com/v1" : "http://localhost:9090";
final string token = isLiveServer ? os:getEnv("SPOTIFY_ACCESS_TOKEN") : "test_token";

final Client spotify = check new ({
    auth: {token},
    httpVersion: isLiveServer ? http:HTTP_2_0 : http:HTTP_1_1
}, serviceUrl);

const string ALBUM_ID = "4m2880jivSbbyEGAKfITCa";
const string ARTIST_ID = "4tZwfgrHOc3mvqYlEYSvVi";
const string TRACK_ID = "2Foc5Q5nqNiosCNqttzHof";
const string SHOW_ID = "38bS44xjbVVZ3No3ByF1dJ";
const string EPISODE_ID = "512ojhOuo1ktJprKbVcKyQ";
const string PLAYLIST_ID = "37i9dQZF1DXcBWIGoYBM5M";

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetAlbum() returns error? {
    AlbumObject response = check spotify->getAlbum(ALBUM_ID);
    test:assertEquals(response.id, ALBUM_ID);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testListAlbumTracks() returns error? {
    PagingSimplifiedTrackObject response = check spotify->listAlbumTracks(ALBUM_ID);
    test:assertTrue((response.items ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetArtist() returns error? {
    ArtistObject response = check spotify->getArtist(ARTIST_ID);
    test:assertEquals(response.id, ARTIST_ID);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testListArtistAlbums() returns error? {
    PagingArtistDiscographyAlbumObject response = check spotify->listArtistAlbums(ARTIST_ID);
    test:assertTrue((response.items ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetTrack() returns error? {
    TrackObject response = check spotify->getTrack(TRACK_ID);
    test:assertEquals(response.id, TRACK_ID);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testSearchItems() returns error? {
    SearchResultsResponse response = check spotify->searchItems(q = "daft punk", 'type = ["track", "artist", "album"]);
    test:assertTrue(response.tracks !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetCurrentUserProfile() returns error? {
    PrivateUserObject response = check spotify->getCurrentUserProfile();
    test:assertTrue(response.id is string);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetPlaylist() returns error? {
    PlaylistObject response = check spotify->getPlaylist(PLAYLIST_ID);
    test:assertEquals(response.id, PLAYLIST_ID);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testListPlaylistItems() returns error? {
    PagingPlaylistTrackObject response = check spotify->listPlaylistItems(PLAYLIST_ID);
    test:assertTrue((response.items ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testAddItemsToPlaylist() returns error? {
    if isLiveServer {
        return;
    }
    PlaylistSnapshotResponse response = check spotify->addItemsToPlaylist(PLAYLIST_ID, {uris: ["spotify:track:" + TRACK_ID]});
    test:assertTrue(response.snapshotId is string);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testCreatePlaylist() returns error? {
    if isLiveServer {
        return;
    }
    PlaylistObject response = check spotify->createPlaylist({name: "Road Trip", description: "Songs for the drive", 'public: false});
    test:assertEquals(response.name, "Road Trip");
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testUpdatePlaylistDetails() returns error? {
    if isLiveServer {
        return;
    }
    error? response = spotify->updatePlaylistDetails(PLAYLIST_ID, {name: "Focus Beats", 'public: true});
    test:assertTrue(response is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testRemovePlaylistItems() returns error? {
    if isLiveServer {
        return;
    }
    PlaylistSnapshotResponse response = check spotify->removePlaylistItems(PLAYLIST_ID, {items: [{uri: "spotify:track:" + TRACK_ID}]});
    test:assertTrue(response.snapshotId is string);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testListCurrentUserPlaylists() returns error? {
    PagingPlaylistObject response = check spotify->listCurrentUserPlaylists();
    test:assertTrue((response.items ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testListSavedTracks() returns error? {
    PagingSavedTrackObject response = check spotify->listSavedTracks();
    test:assertTrue((response.items ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testListTopItems() returns error? {
    PagingArtistOrTrackResponse response = check spotify->listTopItems("tracks");
    test:assertTrue((response.items ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetShow() returns error? {
    ShowObject response = check spotify->getShow(SHOW_ID);
    test:assertEquals(response.id, SHOW_ID);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetEpisode() returns error? {
    EpisodeObject response = check spotify->getEpisode(EPISODE_ID);
    test:assertEquals(response.id, EPISODE_ID);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetPlaybackState() returns error? {
    CurrentlyPlayingContextObject? response = check spotify->getPlaybackState();
    if isLiveServer {
        return;
    }
    test:assertTrue(response?.isPlaying == true);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testListDevices() returns error? {
    DevicesResponse response = check spotify->listDevices();
    test:assertTrue(response.devices.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testSaveLibraryItems() returns error? {
    if isLiveServer {
        return;
    }
    error? response = spotify->saveLibraryItems(uris = "spotify:track:" + TRACK_ID);
    test:assertTrue(response is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testRemoveLibraryItems() returns error? {
    if isLiveServer {
        return;
    }
    error? response = spotify->removeLibraryItems(uris = "spotify:track:" + TRACK_ID);
    test:assertTrue(response is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testListSavedAlbums() returns error? {
    PagingSavedAlbumObject response = check spotify->listSavedAlbums();
    test:assertTrue((response.items ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testListFollowedArtists() returns error? {
    FollowedArtistsResponse response = check spotify->listFollowedArtists('type = "artist");
    test:assertTrue((response.artists.items ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testListRecentlyPlayed() returns error? {
    CursorPagingPlayHistoryObject response = check spotify->listRecentlyPlayed();
    test:assertTrue((response.items ?: []).length() > 0);
}
