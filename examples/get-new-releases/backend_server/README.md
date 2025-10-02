# Spotify New Releases Backend Service

A Ballerina-based backend service that provides API endpoints to fetch new music releases and featured playlists from Spotify using the Spotify Web API.

## Features

- ✅ Get new music releases from Spotify
- ✅ Get featured playlists
- ✅ Country-specific filtering
- ✅ Pagination support
- ✅ CORS enabled for web applications
- ✅ Error handling and logging
- ✅ Health check endpoint

## Prerequisites

1. **Ballerina Swan Lake** (version 2201.4.1 or later)
2. **Spotify Developer Account** with an app created
3. **Spotify API Credentials**:
   - Client ID
   - Client Secret

## Setup Instructions

### 1. Get Spotify API Credentials

1. Visit the [Spotify Developer Dashboard](https://developer.spotify.com/dashboard)
2. Log in with your Spotify account
3. Click "Create App"
4. Fill in the app details:
   - App name: (e.g., "My New Releases App")
   - App description: (e.g., "App to fetch new releases")
   - Redirect URI: `http://localhost:8080/callback` (for testing)
   - APIs used: Web API
5. Save the app and note your **Client ID** and **Client Secret**

### 2. Get Refresh Token

To get a refresh token, you'll need to complete the OAuth2 authorization flow. Here's a quick way:

1. Use the following URL (replace `YOUR_CLIENT_ID` with your actual Client ID):
   ```
   https://accounts.spotify.com/authorize?client_id=YOUR_CLIENT_ID&response_type=code&redirect_uri=http://localhost:8080/callback&scope=user-read-private
   ```

2. Visit the URL, authorize the app, and you'll be redirected to your callback URL with a `code` parameter

3. Exchange the code for tokens using curl:
   ```bash
   curl -X POST "https://accounts.spotify.com/api/token" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "grant_type=authorization_code&code=YOUR_CODE&redirect_uri=http://localhost:8080/callback&client_id=YOUR_CLIENT_ID&client_secret=YOUR_CLIENT_SECRET"
   ```

4. Save the `refresh_token` from the response

### 3. Configure the Application

1. Open `Config.toml`
2. Replace the placeholder values with your actual Spotify credentials:

```toml
[spotify]
clientId = "your_actual_client_id"
clientSecret = "your_actual_client_secret"

[server]
host = "localhost"
port = 8080
```

### 4. Run the Service

```bash
# Navigate to the backend_server directory
cd backend_server

# Run the service
bal run
```

The service will start on `http://localhost:8080`

## API Endpoints

### Health Check
```
GET /api/v1/health
```
Returns the service health status.

**Response:**
```json
{
  "status": "UP",
  "service": "Spotify New Releases API",
  "timestamp": "2025-01-02T...",
  "version": "1.0.0"
}
```

### Get New Releases
```
GET /api/v1/releases
```

**Query Parameters:**
- `country` (optional): ISO 3166-1 alpha-2 country code (e.g., "US", "GB", "SE")
- `limit` (optional): Number of items to return (1-50, default: 20)
- `offset` (optional): Index of first item to return (default: 0)

**Example:**
```
GET /api/v1/releases?country=US&limit=10&offset=0
```

**Response:**
```json
{
  "success": true,
  "data": {
    "message": "New releases fetched successfully",
    "albums": [
      {
        "id": "4aawyAB9vmqN3uQ7FjRGTy",
        "name": "Album Name",
        "album_type": "album",
        "release_date": "2025-01-01",
        "total_tracks": 12,
        "artists": [
          {
            "id": "06HL4z0CvFAxyc27GXpf02",
            "name": "Artist Name",
            "external_urls": {
              "spotify": "https://open.spotify.com/artist/..."
            }
          }
        ],
        "images": [...],
        "external_urls": {...},
        "available_markets": [...]
      }
    ],
    "pagination": {
      "limit": 10,
      "offset": 0,
      "total": 500,
      "next": "...",
      "previous": null
    }
  },
  "timestamp": "2025-01-02T..."
}
```

## Error Handling

All endpoints return appropriate HTTP status codes and error messages:

**Error Response Format:**
```json
{
  "success": false,
  "error": {
    "message": "Failed to fetch new releases",
    "details": "Detailed error message",
    "timestamp": "2025-01-02T..."
  }
}
```

**Common HTTP Status Codes:**
- `200 OK`: Successful request
- `400 Bad Request`: Invalid parameters
- `401 Unauthorized`: Invalid or expired credentials
- `429 Too Many Requests`: Rate limit exceeded
- `500 Internal Server Error`: Server error

## Development

### Project Structure
```
backend_server/
├── Ballerina.toml      # Project configuration
├── Config.toml         # Application configuration
├── main.bal           # Main service implementation
└── README.md          # This file
```

### Dependencies
- `ballerinax/spotify:1.5.1` - Spotify Web API connector
- `ballerina/http:2.6.0` - HTTP client/server
- `ballerina/io:1.4.1` - I/O operations
- `ballerina/log:2.6.0` - Logging

### Configuration
The service uses Ballerina's configurable variables. You can override configuration:

1. **Via Config.toml** (recommended for development)
2. **Via environment variables:**
   ```bash
   export SPOTIFY_CLIENT_ID="your_client_id"
   export SPOTIFY_CLIENT_SECRET="your_client_secret"
   export SPOTIFY_REFRESH_TOKEN="your_refresh_token"
   ```
3. **Via command line:**
   ```bash
   bal run -Cspotify.clientId=your_client_id
   ```

### Logging
The service includes comprehensive logging. Logs include:
- Request information
- Success/error messages
- API call details

### CORS
CORS is configured to allow requests from common development ports. Modify the `cors` configuration in `main.bal` as needed for your frontend application.

## Testing

Test the endpoints using curl or any HTTP client:

```bash
# Health check
curl http://localhost:8080/api/v1/health

# Get new releases
curl http://localhost:8080/api/v1/releases

```

## Troubleshooting

### Common Issues

1. **"Unauthorized" errors**
   - Check your Client ID and Client Secret
   - Ensure your refresh token is valid and not expired
   - Verify the token has the required scopes

2. **"Rate limit exceeded" errors**
   - Spotify has rate limits. Implement retry logic if needed
   - Consider caching responses for better performance

3. **"Service unavailable" errors**
   - Check your internet connection
   - Verify Spotify's service status

### Getting Help

1. Check the [Spotify Web API Documentation](https://developer.spotify.com/documentation/web-api/)
2. Review the [Ballerina Spotify Connector Documentation](https://central.ballerina.io/ballerinax/spotify/latest)
3. Look at the service logs for detailed error information

## License

This project is provided as-is for educational and development purposes. Please ensure you comply with Spotify's API Terms of Service when using this service.