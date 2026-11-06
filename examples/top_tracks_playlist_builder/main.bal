// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
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

// Turns the user's top tracks into a playlist: reads the top tracks for a time range, creates a
// new playlist for the signed-in user and adds those tracks to it. Nothing is created unless
// `createPlaylist` is set to true.

import ballerina/io;
import ballerinax/spotify;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string playlistName = ?;
configurable string timeRange = "short_term";
configurable int trackCount = 20;
configurable boolean createPlaylist = false;

public function main() returns error? {
    spotify:Client spotify = check new ({
        auth: {clientId, clientSecret, refreshToken}
    });

    // Step 1: read the user's top tracks.
    spotify:PagingArtistOrTrackResponse topTracks = check spotify->listTopItems("tracks", timeRange = timeRange, 'limit = trackCount);
    string[] trackUris = [];
    foreach spotify:ArtistObject|spotify:TrackObject item in topTracks.items ?: [] {
        if item is spotify:TrackObject {
            string? uri = item.uri;
            if uri is string {
                trackUris.push(uri);
            }
        }
    }
    if trackUris.length() == 0 {
        return error("No top tracks were returned for the selected time range.");
    }
    io:println(string `Found ${trackUris.length()} top tracks for ${timeRange}.`);

    if !createPlaylist {
        io:println(string `Dry run: set createPlaylist = true to create the playlist "${playlistName}".`);
        return;
    }

    // Step 2: create a private playlist for the signed-in user.
    spotify:PlaylistObject playlist = check spotify->createPlaylist({
        name: playlistName,
        description: string `My top tracks (${timeRange})`,
        'public: false
    });
    string? createdId = playlist.id;
    if createdId is () {
        return error("The created playlist has no ID.");
    }
    string playlistId = createdId;

    // Step 3: add the tracks to the playlist.
    spotify:PlaylistSnapshotResponse snapshot = check spotify->addItemsToPlaylist(playlistId, {uris: trackUris});
    io:println(string `Created playlist ${playlistId} (snapshot ${snapshot.snapshotId ?: "unknown"}).`);
}
