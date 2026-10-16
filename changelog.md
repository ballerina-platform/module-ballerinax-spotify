# Change Log

This file contains all the notable changes done to the Ballerina Spotify connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Operations for the Spotify Web API endpoints added since 1.x: `listPlaylistItems`, `updatePlaylistItems`,
  `addItemsToPlaylist`, `removePlaylistItems`, `createPlaylist`, `saveLibraryItems`, `removeLibraryItems` and
  `checkSavedLibraryItems`.

### Removed

- Every operation marked deprecated in the Spotify Web API specification (48 operations) is removed from the client, with the records only they used. The removed methods, by their 1.x resource form, are:

- `->/albums.get(...)`
- `->/artists.get(...)`
- `->/artists/[id]/related-artists.get(...)`
- `->/artists/[id]/top-tracks.get(...)`
- `->/audio-analysis/[id].get(...)`
- `->/audio-features.get(...)`
- `->/audio-features/[id].get(...)`
- `->/audiobooks.get(...)`
- `->/browse/categories.get(...)`
- `->/browse/categories/[categoryId].get(...)`
- `->/browse/categories/[categoryId]/playlists.get(...)`
- `->/browse/featured-playlists.get(...)`
- `->/browse/new-releases.get(...)`
- `->/chapters.get(...)`
- `->/episodes.get(...)`
- `->/markets.get(...)`
- `->/me/albums.delete(...)`
- `->/me/albums.put(...)`
- `->/me/albums/contains.get(...)`
- `->/me/audiobooks.delete(...)`
- `->/me/audiobooks.put(...)`
- `->/me/audiobooks/contains.get(...)`
- `->/me/episodes.delete(...)`
- `->/me/episodes.put(...)`
- `->/me/episodes/contains.get(...)`
- `->/me/following.delete(...)`
- `->/me/following.put(...)`
- `->/me/following/contains.get(...)`
- `->/me/shows.delete(...)`
- `->/me/shows.put(...)`
- `->/me/shows/contains.get(...)`
- `->/me/tracks.delete(...)`
- `->/me/tracks.put(...)`
- `->/me/tracks/contains.get(...)`
- `->/playlists/[playlistId]/followers.delete(...)`
- `->/playlists/[playlistId]/followers.put(...)`
- `->/playlists/[playlistId]/followers/contains.get(...)`
- `->/playlists/[playlistId]/tracks.delete(...)`
- `->/playlists/[playlistId]/tracks.get(...)`
- `->/playlists/[playlistId]/tracks.post(...)`
- `->/playlists/[playlistId]/tracks.put(...)`
- `->/recommendations.get(...)`
- `->/recommendations/available-genre-seeds.get(...)`
- `->/shows.get(...)`
- `->/tracks.get(...)`
- `->/users/[userId].get(...)`
- `->/users/[userId]/playlists.get(...)`
- `->/users/[userId]/playlists.post(...)`

### Changed

- The client now exposes **remote methods** instead of resource methods. Every 1.x call site changes, as listed below.
  Query parameters are still passed as named arguments, and request payloads are passed as the first argument after
  any path parameters.
- Generated record types are renamed from `InlineResponse*` / `inline_response_*` / `*Body` names to descriptive names,
  for example `MePlaylistsBody` is now `CreatePlaylistRequest` and `MePlayerBody` is now `TransferPlaybackRequest`.

| 1.x resource method | Remote method |
|---|---|
| `->/albums/[id].get(...)` | `->getAlbum(...)` |
| `->/albums/[id]/tracks.get(...)` | `->listAlbumTracks(...)` |
| `->/artists/[id].get(...)` | `->getArtist(...)` |
| `->/artists/[id]/albums.get(...)` | `->listArtistAlbums(...)` |
| `->/audiobooks/[id].get(...)` | `->getAudiobook(...)` |
| `->/audiobooks/[id]/chapters.get(...)` | `->listAudiobookChapters(...)` |
| `->/chapters/[id].get(...)` | `->getChapter(...)` |
| `->/episodes/[id].get(...)` | `->getEpisode(...)` |
| `->/me.get(...)` | `->getCurrentUserProfile(...)` |
| `->/me/albums.get(...)` | `->listSavedAlbums(...)` |
| `->/me/audiobooks.get(...)` | `->listSavedAudiobooks(...)` |
| `->/me/episodes.get(...)` | `->listSavedEpisodes(...)` |
| `->/me/following.get(...)` | `->listFollowedArtists(...)` |
| `->/me/player.get(...)` | `->getPlaybackState(...)` |
| `->/me/player.put(...)` | `->transferPlayback(...)` |
| `->/me/player/currently-playing.get(...)` | `->getCurrentlyPlaying(...)` |
| `->/me/player/devices.get(...)` | `->listDevices(...)` |
| `->/me/player/next.post(...)` | `->skipToNext(...)` |
| `->/me/player/pause.put(...)` | `->pausePlayback(...)` |
| `->/me/player/play.put(...)` | `->startPlayback(...)` |
| `->/me/player/previous.post(...)` | `->skipToPrevious(...)` |
| `->/me/player/queue.get(...)` | `->getQueue(...)` |
| `->/me/player/queue.post(...)` | `->addToQueue(...)` |
| `->/me/player/recently-played.get(...)` | `->listRecentlyPlayed(...)` |
| `->/me/player/repeat.put(...)` | `->setRepeatMode(...)` |
| `->/me/player/seek.put(...)` | `->seekToPosition(...)` |
| `->/me/player/shuffle.put(...)` | `->setShuffle(...)` |
| `->/me/player/volume.put(...)` | `->setPlaybackVolume(...)` |
| `->/me/playlists.get(...)` | `->listCurrentUserPlaylists(...)` |
| `->/me/shows.get(...)` | `->listSavedShows(...)` |
| `->/me/top/[type].get(...)` | `->listTopItems(...)` |
| `->/me/tracks.get(...)` | `->listSavedTracks(...)` |
| `->/playlists/[playlistId].get(...)` | `->getPlaylist(...)` |
| `->/playlists/[playlistId].put(...)` | `->updatePlaylistDetails(...)` |
| `->/playlists/[playlistId]/images.get(...)` | `->getPlaylistCoverImage(...)` |
| `->/playlists/[playlistId]/images.put(...)` | `->uploadPlaylistCoverImage(...)` |
| `->/search.get(...)` | `->searchItems(...)` |
| `->/shows/[id].get(...)` | `->getShow(...)` |
| `->/shows/[id]/episodes.get(...)` | `->listShowEpisodes(...)` |
| `->/tracks/[id].get(...)` | `->getTrack(...)` |
