
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

listener http:Listener ep0 = new (9090);

final ExternalUrlObject mockExternalUrls = {spotify: "https://open.spotify.com/album/4aawyAB9vmqN3uQ7FjRGTy"};

final ImageObject[] mockImages = [
    {url: "https://i.scdn.co/image/ab67616d0000b273b1c5e8d0a2f6a1e1a4c7d3f9", height: 640, width: 640},
    {url: "https://i.scdn.co/image/ab67616d00001e02b1c5e8d0a2f6a1e1a4c7d3f9", height: 300, width: 300}
];

final SimplifiedArtistObject mockSimplifiedArtist = {
    name: "Daft Punk",
    href: "https://api.spotify.com/v1/artists/4tZwfgrHOc3mvqYlEYSvVi",
    id: "4tZwfgrHOc3mvqYlEYSvVi",
    'type: "artist",
    externalUrls: {spotify: "https://open.spotify.com/artist/4tZwfgrHOc3mvqYlEYSvVi"},
    uri: "spotify:artist:4tZwfgrHOc3mvqYlEYSvVi"
};

final ArtistObject mockArtist = {
    name: "Daft Punk",
    href: "https://api.spotify.com/v1/artists/4tZwfgrHOc3mvqYlEYSvVi",
    id: "4tZwfgrHOc3mvqYlEYSvVi",
    'type: "artist",
    externalUrls: {spotify: "https://open.spotify.com/artist/4tZwfgrHOc3mvqYlEYSvVi"},
    uri: "spotify:artist:4tZwfgrHOc3mvqYlEYSvVi",
    genres: ["electro", "french house"],
    popularity: 82,
    followers: {total: 9876543},
    images: mockImages
};

final SimplifiedAlbumObject mockSimplifiedAlbum = {
    images: mockImages,
    availableMarkets: ["US", "GB", "LK"],
    releaseDatePrecision: "day",
    'type: "album",
    uri: "spotify:album:4m2880jivSbbyEGAKfITCa",
    totalTracks: 13,
    releaseDate: "2013-05-17",
    name: "Random Access Memories",
    albumType: "album",
    href: "https://api.spotify.com/v1/albums/4m2880jivSbbyEGAKfITCa",
    id: "4m2880jivSbbyEGAKfITCa",
    externalUrls: mockExternalUrls,
    artists: [mockSimplifiedArtist]
};

final SimplifiedTrackObject mockSimplifiedTrack = {
    discNumber: 1,
    'type: "track",
    uri: "spotify:track:2Foc5Q5nqNiosCNqttzHof",
    durationMs: 369626,
    explicit: false,
    isPlayable: true,
    artists: [mockSimplifiedArtist],
    name: "Get Lucky",
    trackNumber: 8,
    href: "https://api.spotify.com/v1/tracks/2Foc5Q5nqNiosCNqttzHof",
    id: "2Foc5Q5nqNiosCNqttzHof",
    isLocal: false,
    externalUrls: {spotify: "https://open.spotify.com/track/2Foc5Q5nqNiosCNqttzHof"}
};

final TrackObject mockTrack = {
    discNumber: 1,
    album: mockSimplifiedAlbum,
    'type: "track",
    externalIds: {isrc: "USQX91300108"},
    uri: "spotify:track:2Foc5Q5nqNiosCNqttzHof",
    durationMs: 369626,
    explicit: false,
    isPlayable: true,
    artists: [mockSimplifiedArtist],
    popularity: 85,
    name: "Get Lucky",
    trackNumber: 8,
    href: "https://api.spotify.com/v1/tracks/2Foc5Q5nqNiosCNqttzHof",
    id: "2Foc5Q5nqNiosCNqttzHof",
    isLocal: false,
    externalUrls: {spotify: "https://open.spotify.com/track/2Foc5Q5nqNiosCNqttzHof"}
};

final SimplifiedShowObject mockSimplifiedShow = {
    images: mockImages,
    languages: ["en"],
    copyrights: [{text: "(C) 2024 Example Media", 'type: "C"}],
    availableMarkets: ["US", "GB"],
    description: "A weekly conversation about music and technology.",
    'type: "show",
    htmlDescription: "<p>A weekly conversation about music and technology.</p>",
    uri: "spotify:show:38bS44xjbVVZ3No3ByF1dJ",
    isExternallyHosted: false,
    totalEpisodes: 120,
    explicit: false,
    mediaType: "audio",
    name: "Sound Check Weekly",
    publisher: "Example Media",
    href: "https://api.spotify.com/v1/shows/38bS44xjbVVZ3No3ByF1dJ",
    id: "38bS44xjbVVZ3No3ByF1dJ",
    externalUrls: {spotify: "https://open.spotify.com/show/38bS44xjbVVZ3No3ByF1dJ"}
};

final SimplifiedEpisodeObject mockSimplifiedEpisode = {
    images: mockImages,
    languages: ["en"],
    description: "This week we talk about the latest releases.",
    releaseDatePrecision: "day",
    'type: "episode",
    htmlDescription: "<p>This week we talk about the latest releases.</p>",
    uri: "spotify:episode:512ojhOuo1ktJprKbVcKyQ",
    isExternallyHosted: false,
    audioPreviewUrl: "https://p.scdn.co/mp3-preview/episode-preview",
    durationMs: 1686230,
    explicit: false,
    isPlayable: true,
    releaseDate: "2024-03-01",
    name: "Episode 120: New Releases",
    href: "https://api.spotify.com/v1/episodes/512ojhOuo1ktJprKbVcKyQ",
    id: "512ojhOuo1ktJprKbVcKyQ",
    externalUrls: {spotify: "https://open.spotify.com/episode/512ojhOuo1ktJprKbVcKyQ"}
};

final SimplifiedPlaylistObject mockSimplifiedPlaylist = {
    owner: {id: "wizzler", href: "https://api.spotify.com/v1/users/wizzler", 'type: "user", uri: "spotify:user:wizzler", displayName: "Wizzler"},
    images: mockImages,
    snapshotId: "MTY3LGE2ZjA5ZjM2MDQ2YzY0ZjI3",
    collaborative: false,
    description: "Songs to code to",
    'type: "playlist",
    uri: "spotify:playlist:37i9dQZF1DXcBWIGoYBM5M",
    'public: true,
    name: "Focus Beats",
    href: "https://api.spotify.com/v1/playlists/37i9dQZF1DXcBWIGoYBM5M",
    id: "37i9dQZF1DXcBWIGoYBM5M",
    externalUrls: {spotify: "https://open.spotify.com/playlist/37i9dQZF1DXcBWIGoYBM5M"},
    items: {total: 1, href: "https://api.spotify.com/v1/playlists/37i9dQZF1DXcBWIGoYBM5M/items"}
};

final PlaylistObject mockPlaylist = {
    owner: {id: "wizzler", href: "https://api.spotify.com/v1/users/wizzler", 'type: "user", uri: "spotify:user:wizzler", displayName: "Wizzler"},
    images: mockImages,
    snapshotId: "MTY3LGE2ZjA5ZjM2MDQ2YzY0ZjI3",
    collaborative: false,
    description: "Songs to code to",
    'type: "playlist",
    uri: "spotify:playlist:37i9dQZF1DXcBWIGoYBM5M",
    'public: true,
    name: "Focus Beats",
    href: "https://api.spotify.com/v1/playlists/37i9dQZF1DXcBWIGoYBM5M",
    id: "37i9dQZF1DXcBWIGoYBM5M",
    externalUrls: {spotify: "https://open.spotify.com/playlist/37i9dQZF1DXcBWIGoYBM5M"},
    items: {
        href: "https://api.spotify.com/v1/playlists/37i9dQZF1DXcBWIGoYBM5M/items",
        'limit: 20,
        offset: 0,
        total: 1,
        next: (),
        previous: (),
        items: [{addedAt: "2024-03-01T10:00:00Z", isLocal: false, item: mockTrack}]
    }
};

const string PAGE_HREF = "https://api.spotify.com/v1/items";

final AlbumObject mockAlbum = {
    images: mockImages,
    availableMarkets: ["US", "GB", "LK"],
    releaseDatePrecision: "day",
    'type: "album",
    uri: "spotify:album:4m2880jivSbbyEGAKfITCa",
    totalTracks: 13,
    releaseDate: "2013-05-17",
    name: "Random Access Memories",
    albumType: "album",
    href: "https://api.spotify.com/v1/albums/4m2880jivSbbyEGAKfITCa",
    id: "4m2880jivSbbyEGAKfITCa",
    externalUrls: mockExternalUrls,
    artists: [mockSimplifiedArtist],
    copyrights: [{text: "(C) 2013 Daft Life Ltd.", 'type: "C"}],
    genres: [],
    popularity: 80,
    label: "Columbia",
    externalIds: {upc: "886443919266"},
    tracks: {href: PAGE_HREF, 'limit: 20, offset: 0, total: 1, next: (), previous: (), items: [mockSimplifiedTrack]}
};

final ArtistDiscographyAlbumObject mockDiscographyAlbum = {
    images: mockImages,
    availableMarkets: ["US", "GB", "LK"],
    releaseDatePrecision: "day",
    'type: "album",
    uri: "spotify:album:4m2880jivSbbyEGAKfITCa",
    totalTracks: 13,
    releaseDate: "2013-05-17",
    name: "Random Access Memories",
    albumType: "album",
    href: "https://api.spotify.com/v1/albums/4m2880jivSbbyEGAKfITCa",
    id: "4m2880jivSbbyEGAKfITCa",
    externalUrls: mockExternalUrls,
    artists: [mockSimplifiedArtist],
    albumGroup: "album"
};

final EpisodeObject mockEpisode = {
    images: mockImages,
    languages: ["en"],
    description: "This week we talk about the latest releases.",
    releaseDatePrecision: "day",
    'type: "episode",
    htmlDescription: "<p>This week we talk about the latest releases.</p>",
    uri: "spotify:episode:512ojhOuo1ktJprKbVcKyQ",
    isExternallyHosted: false,
    audioPreviewUrl: "https://p.scdn.co/mp3-preview/episode-preview",
    durationMs: 1686230,
    explicit: false,
    isPlayable: true,
    releaseDate: "2024-03-01",
    name: "Episode 120: New Releases",
    href: "https://api.spotify.com/v1/episodes/512ojhOuo1ktJprKbVcKyQ",
    id: "512ojhOuo1ktJprKbVcKyQ",
    externalUrls: {spotify: "https://open.spotify.com/episode/512ojhOuo1ktJprKbVcKyQ"},
    show: mockSimplifiedShow
};

final ShowObject mockShow = {
    images: mockImages,
    languages: ["en"],
    copyrights: [{text: "(C) 2024 Example Media", 'type: "C"}],
    availableMarkets: ["US", "GB"],
    description: "A weekly conversation about music and technology.",
    'type: "show",
    htmlDescription: "<p>A weekly conversation about music and technology.</p>",
    uri: "spotify:show:38bS44xjbVVZ3No3ByF1dJ",
    isExternallyHosted: false,
    totalEpisodes: 120,
    explicit: false,
    mediaType: "audio",
    name: "Sound Check Weekly",
    publisher: "Example Media",
    href: "https://api.spotify.com/v1/shows/38bS44xjbVVZ3No3ByF1dJ",
    id: "38bS44xjbVVZ3No3ByF1dJ",
    externalUrls: {spotify: "https://open.spotify.com/show/38bS44xjbVVZ3No3ByF1dJ"},
    episodes: {href: PAGE_HREF, 'limit: 20, offset: 0, total: 1, next: (), previous: (), items: [mockSimplifiedEpisode]}
};

@http:ServiceConfig {treatNilableAsOptional: true}
service / on ep0 {
    # Remove Playlist Items
    #
    # + playlistId - The Spotify ID of the playlist
    # + payload - Item URIs to remove from the playlist
    # + return - A snapshot ID for the playlist
    resource function delete playlists/[string playlistId]/items(@http:Payload RemovePlaylistItemsRequest payload) returns PlaylistSnapshotResponse|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return {snapshotId: "NCxlNWUyYjc3ZDgwYjEyNmZmNDg3"};
    }

    # Get Album
    #
    # + id - The Spotify ID of the album
    # + market - An ISO 3166-1 alpha-2 country code
    # + return - An album
    resource function get albums/[string id](string? market) returns AlbumObject|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return mockAlbum;
    }

    # Get Album Tracks
    #
    # + id - The Spotify ID of the album
    # + market - An ISO 3166-1 alpha-2 country code
    # + 'limit - Maximum number of items to return
    # + offset - Index of the first item to return
    # + return - Pages of tracks
    resource function get albums/[string id]/tracks(string? market, int 'limit = 20, int offset = 0) returns PagingSimplifiedTrackObject|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return {href: PAGE_HREF, 'limit: 'limit, offset: offset, total: 1, next: (), previous: (), items: [mockSimplifiedTrack]};
    }

    # Get Artist
    #
    # + id - The Spotify ID of the artist
    # + return - An artist
    resource function get artists/[string id]() returns ArtistObject|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return mockArtist;
    }

    # Get Artist's Albums
    #
    # + id - The Spotify ID of the artist
    # + includeGroups - Comma-separated album groups to filter by
    # + market - An ISO 3166-1 alpha-2 country code
    # + 'limit - Maximum number of items to return
    # + offset - Index of the first item to return
    # + return - Pages of albums
    resource function get artists/[string id]/albums(@http:Query {name: "include_groups"} string? includeGroups, string? market, int 'limit = 5, int offset = 0) returns PagingArtistDiscographyAlbumObject|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return {href: PAGE_HREF, 'limit: 'limit, offset: offset, total: 1, next: (), previous: (), items: [mockDiscographyAlbum]};
    }

    # Get Episode
    #
    # + id - The Spotify ID of the episode
    # + market - An ISO 3166-1 alpha-2 country code
    # + return - An episode
    resource function get episodes/[string id](string? market) returns EpisodeObject|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return mockEpisode;
    }

    # Get Current User's Profile
    #
    # + return - A user
    resource function get me() returns PrivateUserObject|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return {
            displayName: "Wizzler",
            'type: "user",
            uri: "spotify:user:wizzler",
            id: "wizzler",
            href: "https://api.spotify.com/v1/users/wizzler",
            externalUrls: {spotify: "https://open.spotify.com/user/wizzler"},
            images: mockImages,
            followers: {total: 42},
            country: "LK",
            email: "wizzler@example.com"
        };
    }

    # Get Playback State
    #
    # + market - An ISO 3166-1 alpha-2 country code
    # + additionalTypes - Comma-separated item types supported by the client
    # + return - Information about playback
    resource function get me/player(string? market, @http:Query {name: "additional_types"} string? additionalTypes) returns CurrentlyPlayingContextObject|http:NoContent|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return {
            device: {id: "74ASZWbe4lXaubB36ztrGX", isActive: true, isPrivateSession: false, isRestricted: false, name: "Living Room Speaker", 'type: "Speaker", volumePercent: 55, supportsVolume: true},
            repeatState: "off",
            shuffleState: false,
            context: {'type: "album", href: "https://api.spotify.com/v1/albums/4m2880jivSbbyEGAKfITCa", uri: "spotify:album:4m2880jivSbbyEGAKfITCa"},
            timestamp: 1710000000000,
            progressMs: 60000,
            isPlaying: true,
            item: mockTrack,
            currentlyPlayingType: "track",
            actions: {pausing: true}
        };
    }

    # Get Available Devices
    #
    # + return - A set of devices
    resource function get me/player/devices() returns DevicesResponse|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return {
            devices: [
                {id: "74ASZWbe4lXaubB36ztrGX", isActive: true, isPrivateSession: false, isRestricted: false, name: "Living Room Speaker", 'type: "Speaker", volumePercent: 55, supportsVolume: true},
                {id: "9a1d3c5e7f2b4a6c8e0d1f3b5a7c9e2d4f6a8b0c", isActive: false, isPrivateSession: false, isRestricted: false, name: "Pixel 8", 'type: "Smartphone", volumePercent: 30, supportsVolume: true}
            ]
        };
    }

    # Get Current User's Playlists
    #
    # + 'limit - Maximum number of items to return
    # + offset - Index of the first item to return
    # + return - A paged set of playlists
    resource function get me/playlists(int 'limit = 20, int offset = 0) returns PagingPlaylistObject|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return {href: PAGE_HREF, 'limit: 'limit, offset: offset, total: 1, next: (), previous: (), items: [mockSimplifiedPlaylist]};
    }

    # Get User's Top Items
    #
    # + 'type - The type of entity to return
    # + timeRange - Over what time frame the affinities are computed
    # + 'limit - Maximum number of items to return
    # + offset - Index of the first item to return
    # + return - Pages of artists or tracks
    resource function get me/top/["artists"|"tracks" 'type](@http:Query {name: "time_range"} string timeRange = "medium_term", int 'limit = 20, int offset = 0) returns PagingArtistOrTrackResponse|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        if 'type == "artists" {
            return {href: PAGE_HREF, 'limit: 'limit, offset: offset, total: 1, next: (), previous: (), items: [mockArtist]};
        }
        return {href: PAGE_HREF, 'limit: 'limit, offset: offset, total: 1, next: (), previous: (), items: [mockTrack]};
    }

    # Get User's Saved Tracks
    #
    # + market - An ISO 3166-1 alpha-2 country code
    # + 'limit - Maximum number of items to return
    # + offset - Index of the first item to return
    # + return - Pages of saved tracks
    resource function get me/tracks(string? market, int 'limit = 20, int offset = 0) returns PagingSavedTrackObject|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return {href: PAGE_HREF, 'limit: 'limit, offset: offset, total: 1, next: (), previous: (), items: [{addedAt: "2024-02-14T08:30:00Z", track: mockTrack}]};
    }

    # Get Playlist
    #
    # + playlistId - The Spotify ID of the playlist
    # + market - An ISO 3166-1 alpha-2 country code
    # + fields - Filters for the query
    # + additionalTypes - Comma-separated item types supported by the client
    # + return - A playlist
    resource function get playlists/[string playlistId](string? market, string? fields, @http:Query {name: "additional_types"} string? additionalTypes) returns PlaylistObject|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return mockPlaylist;
    }

    # Get Playlist Items
    #
    # + playlistId - The Spotify ID of the playlist
    # + market - An ISO 3166-1 alpha-2 country code
    # + fields - Filters for the query
    # + additionalTypes - Comma-separated item types supported by the client
    # + 'limit - Maximum number of items to return
    # + offset - Index of the first item to return
    # + return - Pages of playlist items
    resource function get playlists/[string playlistId]/items(string? market, string? fields, @http:Query {name: "additional_types"} string? additionalTypes, int 'limit = 20, int offset = 0) returns PagingPlaylistTrackObject|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return {href: PAGE_HREF, 'limit: 'limit, offset: offset, total: 1, next: (), previous: (), items: [{addedAt: "2024-03-01T10:00:00Z", isLocal: false, item: mockTrack}]};
    }

    # Search for Item
    #
    # + q - The search query
    # + 'type - Item types to search across
    # + market - An ISO 3166-1 alpha-2 country code
    # + includeExternal - Whether externally hosted audio may be included
    # + 'limit - Maximum number of items to return
    # + offset - Index of the first item to return
    # + return - Search response
    resource function get search(string q, ("album"|"artist"|"playlist"|"track"|"show"|"episode"|"audiobook")[] 'type, string? market, @http:Query {name: "include_external"} "audio"? includeExternal, int 'limit = 5, int offset = 0) returns SearchResultsResponse|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return {
            tracks: {href: PAGE_HREF, 'limit: 'limit, offset: offset, total: 1, next: (), previous: (), items: [mockTrack]},
            artists: {href: PAGE_HREF, 'limit: 'limit, offset: offset, total: 1, next: (), previous: (), items: [mockArtist]},
            albums: {href: PAGE_HREF, 'limit: 'limit, offset: offset, total: 1, next: (), previous: (), items: [mockSimplifiedAlbum]}
        };
    }

    # Get Show
    #
    # + id - The Spotify ID of the show
    # + market - An ISO 3166-1 alpha-2 country code
    # + return - A show
    resource function get shows/[string id](string? market) returns ShowObject|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return mockShow;
    }

    # Get Track
    #
    # + id - The Spotify ID of the track
    # + market - An ISO 3166-1 alpha-2 country code
    # + return - A track
    resource function get tracks/[string id](string? market) returns TrackObject|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return mockTrack;
    }

    # Create Playlist
    #
    # + payload - Name, description, and visibility of the playlist to create
    # + return - A playlist
    resource function post me/playlists(@http:Payload CreatePlaylistRequest payload) returns PlaylistObject|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        PlaylistObject created = mockPlaylist.clone();
        created.name = payload.name;
        return created;
    }

    # Add Items to Playlist
    #
    # + playlistId - The Spotify ID of the playlist
    # + position - Zero-based position to insert the items
    # + uris - Comma-separated Spotify URIs to add
    # + payload - Item URIs and optional position to add to the playlist
    # + return - A snapshot ID for the playlist
    resource function post playlists/[string playlistId]/items(int? position, string? uris, @http:Payload AddItemsToPlaylistRequest payload) returns PlaylistSnapshotResponse|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return {snapshotId: "MTY3LGE2ZjA5ZjM2MDQ2YzY0ZjI3"};
    }

    # Change Playlist Details
    #
    # + playlistId - The Spotify ID of the playlist
    # + payload - Playlist name, description, and visibility details to change
    # + return - Playlist updated
    resource function put playlists/[string playlistId](@http:Payload UpdatePlaylistDetailsRequest payload) returns http:Ok|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return http:OK;
    }

    # Save Items to Library
    #
    # + uris - Comma-separated Spotify URIs to save
    # + return - Items saved
    resource function put me/library(string uris) returns http:Ok|ErrorObjectBadRequest|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return http:OK;
    }

    # Remove Items from Library
    #
    # + uris - Comma-separated Spotify URIs to remove
    # + return - Items removed
    resource function delete me/library(string uris) returns http:Ok|ErrorObjectBadRequest|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return http:OK;
    }

    # Get User's Saved Albums
    #
    # + market - An ISO 3166-1 alpha-2 country code
    # + 'limit - Maximum number of items to return
    # + offset - Index of the first item to return
    # + return - Pages of saved albums
    resource function get me/albums(string? market, int 'limit = 20, int offset = 0) returns PagingSavedAlbumObject|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return {href: PAGE_HREF, 'limit: 'limit, offset: offset, total: 1, next: (), previous: (), items: [{addedAt: "2024-02-14T08:30:00Z", album: mockAlbum}]};
    }

    # Get Followed Artists
    #
    # + 'type - The ID type, currently only artist is supported
    # + after - The last artist ID retrieved from the previous request
    # + 'limit - Maximum number of items to return
    # + return - A cursor-paged set of artists
    resource function get me/following("artist" 'type, string? after, int 'limit = 20) returns FollowedArtistsResponse|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return {artists: {href: PAGE_HREF, 'limit: 'limit, total: 1, next: (), cursors: {after: "4tZwfgrHOc3mvqYlEYSvVi"}, items: [mockArtist]}};
    }

    # Get Recently Played Tracks
    #
    # + after - Unix timestamp in milliseconds to return items after
    # + before - Unix timestamp in milliseconds to return items before
    # + 'limit - Maximum number of items to return
    # + return - A cursor-paged set of play history items
    resource function get me/player/recently\-played(int? after, int? before, int 'limit = 20) returns CursorPagingPlayHistoryObject|InlineResponse401Unauthorized|InlineResponse401Forbidden|InlineResponse401TooManyRequests {
        return {href: PAGE_HREF, 'limit: 'limit, total: 1, next: (), items: [{track: mockTrack, playedAt: "2024-03-01T10:05:00Z", context: {'type: "album", uri: "spotify:album:4m2880jivSbbyEGAKfITCa"}}]};
    }
}

// Service-mode response types. `bal openapi --mode client` collapses 4XX/5XX
// to `error` and never emits these, so they are defined here for the mock only.
public type MockError record {|
    int status;
    string message;
|};

public type ErrorBody record {|
    MockError 'error;
|};

public type ErrorObjectBadRequest record {|
    *http:BadRequest;
    ErrorBody body;
|};

public type InlineResponse401Forbidden record {|
    *http:Forbidden;
    ErrorBody body;
|};

public type InlineResponse401TooManyRequests record {|
    *http:TooManyRequests;
    ErrorBody body;
|};

public type InlineResponse401Unauthorized record {|
    *http:Unauthorized;
    ErrorBody body;
|};
