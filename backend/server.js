// Instagram API Proxy Server
// This server acts as a middleman between your web app and Instagram API
// Solves CORS issues

const express = require('express');
const cors = require('cors');
const axios = require('axios');
const app = express();

// Enable CORS for your frontend
app.use(cors({
  origin: '*', // Allow all origins for testing, restrict in production
  methods: ['GET', 'POST'],
  credentials: true
}));

app.use(express.json());

// Instagram API Configuration
const INSTAGRAM_CONFIG = {
  appId: '1165210255788505',
  appSecret: 'f3b0c680d7af049b564e26dbf9c9447c',
  redirectUri: 'https://localhost/callback',
  tokenUrl: 'https://api.instagram.com/oauth/access_token',
  graphApiUrl: 'https://graph.instagram.com'
};

// Exchange authorization code for access token
app.post('/api/instagram/token', async (req, res) => {
  try {
    const { code } = req.body;

    if (!code) {
      return res.status(400).json({ error: 'Authorization code is required' });
    }

    // Make request to Instagram
    const response = await axios.post(
      INSTAGRAM_CONFIG.tokenUrl,
      new URLSearchParams({
        client_id: INSTAGRAM_CONFIG.appId,
        client_secret: INSTAGRAM_CONFIG.appSecret,
        grant_type: 'authorization_code',
        redirect_uri: INSTAGRAM_CONFIG.redirectUri,
        code: code
      }),
      {
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      }
    );

    res.json(response.data);
  } catch (error) {
    console.error('Error getting access token:', error.response?.data || error.message);
    res.status(500).json({
      error: 'Failed to get access token',
      details: error.response?.data || error.message
    });
  }
});

// Get user profile
app.get('/api/instagram/profile', async (req, res) => {
  try {
    const { accessToken, userId } = req.query;

    if (!accessToken || !userId) {
      return res.status(400).json({ error: 'Access token and user ID are required' });
    }

    const response = await axios.get(
      `${INSTAGRAM_CONFIG.graphApiUrl}/${userId}`,
      {
        params: {
          fields: 'id,username,account_type,media_count',
          access_token: accessToken
        }
      }
    );

    res.json(response.data);
  } catch (error) {
    console.error('Error getting user profile:', error.response?.data || error.message);
    res.status(500).json({
      error: 'Failed to get user profile',
      details: error.response?.data || error.message
    });
  }
});

// Get user media
app.get('/api/instagram/media', async (req, res) => {
  try {
    const { accessToken, userId, limit = 25 } = req.query;

    if (!accessToken || !userId) {
      return res.status(400).json({ error: 'Access token and user ID are required' });
    }

    const response = await axios.get(
      `${INSTAGRAM_CONFIG.graphApiUrl}/${userId}/media`,
      {
        params: {
          fields: 'id,caption,media_type,media_url,thumbnail_url,permalink,timestamp,username',
          limit: limit,
          access_token: accessToken
        }
      }
    );

    res.json(response.data);
  } catch (error) {
    console.error('Error getting user media:', error.response?.data || error.message);
    res.status(500).json({
      error: 'Failed to get user media',
      details: error.response?.data || error.message
    });
  }
});

// Get long-lived token
app.get('/api/instagram/long-lived-token', async (req, res) => {
  try {
    const { accessToken } = req.query;

    if (!accessToken) {
      return res.status(400).json({ error: 'Access token is required' });
    }

    const response = await axios.get(
      `${INSTAGRAM_CONFIG.graphApiUrl}/access_token`,
      {
        params: {
          grant_type: 'ig_exchange_token',
          client_secret: INSTAGRAM_CONFIG.appSecret,
          access_token: accessToken
        }
      }
    );

    res.json(response.data);
  } catch (error) {
    console.error('Error getting long-lived token:', error.response?.data || error.message);
    res.status(500).json({
      error: 'Failed to get long-lived token',
      details: error.response?.data || error.message
    });
  }
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'OK', message: 'Instagram API Proxy is running' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`🚀 Instagram API Proxy Server running on port ${PORT}`);
  console.log(`📍 Health check: http://localhost:${PORT}/health`);
  console.log(`📍 Token endpoint: http://localhost:${PORT}/api/instagram/token`);
});
