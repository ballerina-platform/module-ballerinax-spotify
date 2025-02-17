import ballerina/io;
import ballerinax/spotify;

configurable string token = ?;

public function main(string artistId) returns error? {
    spotify:Client spotify = check new ({
        auth: {
            token
        }
    });

    // Get artist's albums
    spotify:PagingArtistDiscographyAlbumObject albums = check spotify->/artists/[artistId]/albums;
    
    // Get artist details
    spotify:ArtistObject artist = check spotify->/artists/[artistId];
    
    // Print artist information
    io:println("\nArtist Details:");
    io:println("==============");
    io:println("Name: ", artist.name);
    io:println("Genres: ", artist.genres.toString());
    io:println("Followers: ", artist.followers.total);
    
    // Print albums information
    io:println("\nAlbums Information:");
    io:println("=================");
    io:println("Total Albums: ", albums.total);
    
    io:println("\nAlbum List:");
    io:println("===========");
    foreach var album in albums.items {
        io:println(string `${album.name} (${album.release_date}) - Type: ${album.album_type}`);
    }
}
