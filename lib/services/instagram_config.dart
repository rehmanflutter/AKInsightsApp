/// Instagram API Configuration
///
/// IMPORTANT: Before using this app with real Instagram data, you MUST:
/// 1. Create an app at https://developers.facebook.com/
/// 2. Add Instagram Basic Display product
/// 3. Get your App ID and App Secret
/// 4. Add OAuth Redirect URI: https://localhost/callback
/// 5. Replace the values below with your actual credentials
///
/// See INSTAGRAM_SETUP_GUIDE.md for detailed setup instructions
class InstagramConfig {
  // YOUR Instagram App credentials from https://developers.facebook.com/apps/
  // This allows ANY USER to login with their Instagram account
  static const String appId = '1165210255788505';
  static const String appSecret = 'f3b0c680d7af049b564e26dbf9c9447c';

  // Redirect URI - must match EXACTLY what you set in Facebook Developer Console
  // For web testing: https://localhost/callback
  // For mobile: you can use a custom scheme like: myapp://callback
  static const String redirectUri = 'https://localhost/callback';

  // Check if app is configured
  static bool get isConfigured {
    // App is configured if we have valid credentials
    return appId.isNotEmpty &&
        appSecret.isNotEmpty &&
        appId != 'YOUR_APP_ID_HERE' &&
        appSecret != 'YOUR_APP_SECRET_HERE';
  }

  // Instagram OAuth URLs
  static const String authorizationUrl =
      'https://api.instagram.com/oauth/authorize';
  static const String tokenUrl = 'https://api.instagram.com/oauth/access_token';
  static const String graphApiUrl = 'https://graph.instagram.com';

  // Scopes - what data you want to access
  static const String scope = 'user_profile,user_media';

  // Build authorization URL
  static String getAuthorizationUrl() {
    return '$authorizationUrl?client_id=$appId&redirect_uri=$redirectUri&scope=$scope&response_type=code';
  }
}
