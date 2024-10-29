_Author_:  @Sachindu-Nethmin\
_Created_: 2024/10/22\
_Updated_: 2024/10/22\
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Spotify. 
The OpenAPI specification is obtained from the [Spotify OpenAPI Documentation](https://developer.spotify.com/reference/web-api/open-api-schema.yaml).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.


1. Remove resource paths,
  In '/playlists/{playlist_id}/images'
    Remove the required Field from the Schema because required attribute within the schema for the image/jpeg content type is incorrectly defined
2.Moving the inline schema to the components section
    1.MarketsResponse
    2.PlaylistResponse
    3.ArtistObjects
    4.ManyTrackObject
    5.ManyAudioFeaturesObject
    6.PagedCategoriesObject
    7.PagedAlbumsObject
    8.CursorPagedArtistsObject
    9.ManyDevicesObject
    10.PagingArtistOrTrackObject
    11.ManyGenresObject
    12.SearchItemsObject
    13.ManySimplifiedShowsObject
    14.ManyAlbumsObject
    15.ManyAudiobooksObject
    16.ManyChaptersObject
    17.ManyEpisodesObject
    18.PlaylistSnapshotIdObject

3.  Remove bad responses to increase readability.
        401':
          $ref: '#/components/responses/Unauthorized'
        '403':
          $ref: '#/components/responses/Forbidden'
        '429':
          $ref: '#/components/responses/TooManyRequests'

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/openapi.yaml --mode client --license docs/license.txt -o ballerina --use-sanitized-oas
```
Note: The license year is hardcoded to 2024, change if necessary.
