# Instagram API Proxy Server

## Why This Server is Needed?

Instagram API doesn't allow direct calls from browsers due to CORS (Cross-Origin Resource Sharing) restrictions. This proxy server acts as a middleman:

```
Browser (Flutter Web) → Proxy Server → Instagram API
                     ←               ←
```

## Setup Instructions

### 1. Install Node.js
Download from: https://nodejs.org/

### 2. Install Dependencies
```bash
cd backend
npm install
```

### 3. Run the Server
```bash
npm start
```

Server will run on: `http://localhost:3000`

### 4. Update Flutter App
The Flutter app will automatically use this proxy server when running on web.

## Endpoints

### POST /api/instagram/token
Exchange authorization code for access token
```json
Request: { "code": "AUTH_CODE" }
Response: { "access_token": "...", "user_id": "..." }
```

### GET /api/instagram/profile
Get user profile
```
Query: ?accessToken=TOKEN&userId=ID
Response: { "id": "...", "username": "...", "media_count": 123 }
```

### GET /api/instagram/media
Get user media
```
Query: ?accessToken=TOKEN&userId=ID&limit=25
Response: { "data": [...] }
```

### GET /api/instagram/long-lived-token
Exchange short-lived token for long-lived (60 days)
```
Query: ?accessToken=SHORT_TOKEN
Response: { "access_token": "LONG_TOKEN", "expires_in": 5183944 }
```

## Deployment

### Option 1: Deploy on Render.com (Free)
1. Create account on render.com
2. New Web Service
3. Connect GitHub repo
4. Deploy!

### Option 2: Deploy on Railway.app (Free)
1. Create account on railway.app
2. New Project → Deploy from GitHub
3. Done!

### Option 3: Deploy on Heroku
```bash
heroku create your-app-name
git push heroku main
```

## Production Notes

- Change `origin: '*'` to your specific domain in CORS config
- Add environment variables for API credentials
- Enable HTTPS
- Add rate limiting
- Add logging
