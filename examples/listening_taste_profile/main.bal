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

// Builds a listening taste profile for the signed-in user: reads the user's profile, then the
// top artists and top tracks over a chosen time range, and summarises the favourite genres.

import ballerina/io;
import ballerinax/spotify;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string timeRange = "medium_term";
configurable int topCount = 10;

public function main() returns error? {
    spotify:Client spotify = check new ({
        auth: {clientId, clientSecret, refreshToken}
    });

    // Step 1: read the profile of the signed-in user.
    spotify:PrivateUserObject profile = check spotify->getCurrentUserProfile();
    string displayName = profile.displayName ?: profile.id ?: "unknown user";
    io:println(string `Taste profile for ${displayName} (${timeRange})`);

    // Step 2: read the user's top artists and count their genres.
    spotify:PagingArtistOrTrackResponse topArtists = check spotify->listTopItems("artists", timeRange = timeRange, 'limit = topCount);
    map<int> genreCounts = {};
    io:println("Top artists:");
    foreach spotify:ArtistObject|spotify:TrackObject item in topArtists.items ?: [] {
        if item is spotify:ArtistObject {
            io:println(string `  ${item.name ?: "unknown"}`);
            foreach string genre in item.genres ?: [] {
                genreCounts[genre] = (genreCounts[genre] ?: 0) + 1;
            }
        }
    }

    // Step 3: read the user's top tracks.
    spotify:PagingArtistOrTrackResponse topTracks = check spotify->listTopItems("tracks", timeRange = timeRange, 'limit = topCount);
    io:println("Top tracks:");
    foreach spotify:ArtistObject|spotify:TrackObject item in topTracks.items ?: [] {
        if item is spotify:TrackObject {
            string artistName = (item.artists ?: []).length() > 0 ? (item.artists ?: [])[0].name ?: "unknown artist" : "unknown artist";
            io:println(string `  ${item.name ?: "unknown"} by ${artistName}`);
        }
    }

    // Step 4: report the most common genres among the top artists.
    string[] genres = from [string, int] [genre, count] in genreCounts.entries()
        order by count descending
        select genre;
    io:println("Favourite genres:");
    foreach string genre in genres.slice(0, int:min(5, genres.length())) {
        io:println(string `  ${genre} (${genreCounts.get(genre)} artists)`);
    }
}
