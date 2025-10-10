// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
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
import ballerina/log;
import ballerina/time;
import ballerinax/spotify;

// Configuration records
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string host = "localhost";
configurable int port = 8080;

// API response types for the examples
public type ErrorDetails record {
    string message;
    string details?;
    string timestamp;
};

public type ErrorResponse record {
    boolean success = false;
    ErrorDetails errorInfo;
};

public type NewReleasesResponse record {
    boolean success = true;
    spotify:PagedAlbumsObject data;
    string timestamp;
};

// Function to get access token using client credentials
isolated function getAccessToken() returns string|error {
    http:Client tokenClient = check new ("https://accounts.spotify.com");
    
    string credentials = clientId + ":" + clientSecret;
    string encodedCredentials = credentials.toBytes().toBase64();
    
    http:Request request = new;
    request.setHeader("Authorization", "Basic " + encodedCredentials);
    request.setHeader("Content-Type", "application/x-www-form-urlencoded");
    request.setTextPayload("grant_type=client_credentials");
    
    http:Response response = check tokenClient->post("/api/token", request);
    
    if (response.statusCode == 200) {
        json payload = check response.getJsonPayload();
        json|error accessToken = payload.access_token;
        if (accessToken is string) {
            log:printInfo("Successfully obtained access token");
            return accessToken;
        } else {
            log:printError("Failed to extract access token from response");
            return error("Failed to extract access token from response");
        }
    } else {
        string responseBody = check response.getTextPayload();
        string errorMsg = string `Failed to get access token. Status: ${response.statusCode}, Body: ${responseBody}`;
        log:printError(errorMsg);
        return error(errorMsg);
    }
}

// Initialize Spotify client
spotify:Client spotifyClient = check new ({
    auth: {
        token: check getAccessToken()
    }
});

// CORS configuration
@http:ServiceConfig {
    cors: {
        allowOrigins: ["http://localhost:3000", "http://localhost:8080", "*"],
        allowCredentials: false,
        allowHeaders: ["CORELATION_ID", "Authorization", "Content-Type"],
        allowMethods: ["GET", "POST", "PUT", "DELETE", "OPTIONS", "HEAD"]
    }
}
service / on new http:Listener(port) {

    // Health check endpoint
    resource function get health() returns json {
        return {
            "status": "UP",
            "service": "Spotify New Releases API",
            "timestamp": timestamp(),
            "version": "1.0.0"
        };
    }

    // Get new releases from Spotify
    resource function get new\-releases(
        string? country = (),
        int? 'limit = 20,
        int? offset = 0
    ) returns NewReleasesResponse|ErrorResponse|http:InternalServerError {
        
        log:printInfo("Fetching new releases from Spotify API");
        
        do {
            // Validate parameters
            int validLimit = 'limit ?: 20;
            int validOffset = offset ?: 0;
            
            // Ensure limit is within Spotify's constraints (1-50)
            if (validLimit < 1) {
                validLimit = 1;
            } else if (validLimit > 50) {
                validLimit = 50;
            }
            
            // Ensure offset is not negative
            if (validOffset < 0) {
                validOffset = 0;
            }
            
            log:printInfo(string `Requesting new releases with country: ${country ?: "all"}, limit: ${validLimit}, offset: ${validOffset}`);
            
            // Call Spotify API using direct HTTP request to avoid depending on connector method versions
            spotify:PagedAlbumsObject newReleases = check NewReleases(country, validLimit, validOffset);

            NewReleasesResponse response = {
                success: true,
                data: newReleases,
                timestamp: timestamp()
            };

            log:printInfo("Successfully fetched new releases");
            return response;
        } else {
                log:printError("Error converting response to JSON", 'error = responseJson);
                ErrorResponse errResp = {
                    success: false,
                    errorInfo: {
                        message: "Failed to process response",
                        details: "JSON conversion error",
                        timestamp: timestamp()
                    }
                };
                return <http:InternalServerError>{ body: errResp };
            }
            
        } on fail error e {
            log:printError("Error fetching new releases", 'error = e);
            ErrorResponse errResp = {
                success: false,
                errorInfo: {
                    message: "Failed to fetch new releases",
                    details: e.message(),
                    timestamp: timestamp()
                }
            };
            return <http:InternalServerError>{ body: errResp };
        }
    }

    // Get new releases by country
    resource function get new\-releases/[string country](
        int? 'limit = 20,
        int? offset = 0
    ) returns NewReleasesResponse|ErrorResponse|http:InternalServerError {
        log:printInfo("Fetching new releases for country: " + country);
        
        do {
            // Validate parameters
            int validLimit = 'limit ?: 20;
            int validOffset = offset ?: 0;
            
            // Ensure limit is within Spotify's constraints (1-50)
            if (validLimit < 1) {
                validLimit = 1;
            } else if (validLimit > 50) {
                validLimit = 50;
            }
            
            // Ensure offset is not negative
            if (validOffset < 0) {
                validOffset = 0;
            }
            
            log:printInfo(string `Requesting new releases with country: ${country}, limit: ${validLimit}, offset: ${validOffset}`);
            
            // Call Spotify API using direct HTTP request to avoid depending on connector method versions
            spotify:PagedAlbumsObject newReleases = check NewReleases(country, validLimit, validOffset);

            NewReleasesResponse response = {
                success: true,
                data: newReleases,
                timestamp: timestamp()
            };

            log:printInfo("Successfully fetched new releases");
            return response;
        } else {
                log:printError("Error converting response to JSON", 'error = responseJson);
                ErrorResponse errResp = {
                    success: false,
                    errorInfo: {
                        message: "Failed to process response",
                        details: "JSON conversion error",
                        timestamp: timestamp()
                    }
                };
                return <http:InternalServerError>{ body: errResp };
            }
            
        } on fail error e {
            log:printError("Error fetching new releases", 'error = e);
            ErrorResponse errResp = {
                success: false,
                errorInfo: {
                    message: "Failed to fetch new releases",
                    details: e.message(),
                    timestamp: timestamp()
                }
            };
            return <http:InternalServerError>{ body: errResp };
        }
    }

    // Get featured playlists (bonus endpoint)
    resource function get featured\-playlists(
        string? country = (),
        int? 'limit = 20,
        int? offset = 0
    ) returns json|http:InternalServerError {
        
        log:printInfo("Fetching featured playlists from Spotify API");
        
        do {
            int validLimit = 'limit ?: 20;
            int validOffset = offset ?: 0;
            
            if (validLimit < 1) {
                validLimit = 1;
            } else if (validLimit > 50) {
                validLimit = 50;
            }
            
            if (validOffset < 0) {
                validOffset = 0;
            }
            
            spotify:FeaturedPlaylistObject featuredPlaylists = check spotifyClient->getFeaturedPlaylists(
                country, (), (), validLimit, validOffset
            );
            
            // Convert the entire response to JSON
            json|error responseJson = featuredPlaylists.cloneWithType(json);
            
            if (responseJson is json) {
                json response = {
                    "success": true,
                    "data": responseJson,
                    "timestamp": timestamp()
                };
                
                log:printInfo("Successfully fetched featured playlists");
                return response;
            } else {
                log:printError("Error converting response to JSON", 'error = responseJson);
                return <http:InternalServerError>{
                    body: {
                        "success": false,
                        "error": {
                            "message": "Failed to process featured playlists response",
                            "details": "JSON conversion error",
                            "timestamp": timestamp()
                        }
                    }
                };
            }
            
        } on fail error e {
            log:printError("Error fetching featured playlists", 'error = e);
            return <http:InternalServerError>{
                body: {
                    "success": false,
                    "error": {
                        "message": "Failed to fetch featured playlists",
                        "details": e.message(),
                        "timestamp": timestamp()
                    }
                }
            };
        }
    }
}

// Helper function to get current timestamp
function timestamp() returns string {
    // Get current UTC time and convert to ISO 8601 string
    time:Utc currentTime = time:utcNow();
    return time:utcToString(currentTime);
}

// Helper to fetch new releases from Spotify Web API using client credentials token
isolated function NewReleases(string? country, int lim, int off) returns spotify:PagedAlbumsObject|error {
    // Build query string
    string query = "?limit=" + lim.toString() + "&offset=" + off.toString();
    if country is string {
        query = query + "&country=" + country;
    }

    // Get a fresh token using the same client credentials helper
    string token = check getAccessToken();

    http:Client apiClient = check new ("https://api.spotify.com/v1");

    map<string|string[]> headers = {"Authorization": ["Bearer " + token]};
    http:Response resp = check apiClient->get("/browse/new-releases" + query, headers);
    if resp.statusCode == 200 {
        json payload = check resp.getJsonPayload();
        json|error converted = payload.cloneWithType(spotify:PagedAlbumsObject);
        if converted is spotify:PagedAlbumsObject {
            return converted;
        } else {
            return error("Failed to convert payload to spotify:PagedAlbumsObject");
        }
    } else {
        string body = check resp.getTextPayload();
        return error("Spotify API returned " + resp.statusCode.toString() + ": " + body);
    }
}
