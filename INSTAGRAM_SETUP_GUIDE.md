# Instagram API Setup Guide

This app now integrates with Instagram's official API to show real data. Follow these steps to configure it:

## Quick Start (No Setup)

**Just want to test the app?** Click "Continue with Demo Data" on the login screen - no Instagram setup required!

## Important Limitations

Instagram's official API has limitations:
- **NOT Available**: "Secret stalkers", "who blocked me", "profile visitors", "story viewers"
- **Available**: Profile info, posts/media count, and basic engagement metrics
- **Basic Display API**: Limited to profile and media data
- **Graph API**: Requires Business/Creator account for follower counts

## Setup Steps

### 1. Create a Facebook App

1. Go to [Facebook Developers](https://developers.facebook.com/)
2. Click "My Apps" > "Create App"
3. Select "Consumer" as the app type
4. Fill in app details and create the app

### 2. Add Instagram Basic Display Product

1. In your app dashboard, click "Add Product"
2. Find "Instagram Basic Display" and click "Set Up"
3. Go to "Basic Display" settings

### 3. Configure OAuth Settings

1. In Instagram Basic Display Settings:
   - **Valid OAuth Redirect URIs**: Add `https://localhost/callback`
   - **Deauthorize Callback URL**: Add any URL (e.g., `https://localhost/deauth`)
   - **Data Deletion Request URL**: Add any URL (e.g., `https://localhost/delete`)
   - Save changes

### 4. Add Instagram Test Account

1. Scroll down to "User Token Generator"
2. Click "Add or Remove Instagram Testers"
3. Add your Instagram account username
4. Go to your Instagram app > Settings > Apps and Websites
5. Accept the tester invitation

### 5. Get Your App Credentials

1. In your Facebook app, go to Settings > Basic
2. Copy your **App ID** and **App Secret**
3. Open `lib/services/instagram_config.dart` in this project
4. Replace the placeholder values:

```dart
static const String appId = 'YOUR_INSTAGRAM_APP_ID';
static const String appSecret = 'YOUR_INSTAGRAM_APP_SECRET';
```

### 6. Run the App

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run
```

### 7. Login with Instagram

#### On Mobile (iOS/Android):
1. Open the app
2. Click "Login with Instagram"
3. Authorize the app in the WebView
4. You'll be redirected back and see your real Instagram data

#### On Web (Browser):
1. Open the app in your browser
2. Click "Login with Instagram"
3. A dialog will appear with instructions
4. Click "Open Instagram Login" - a new tab will open
5. Authorize the app
6. Instagram will redirect to: `https://localhost/callback?code=XXXXX`
7. Copy the code value from the URL (everything after `code=`)
8. Paste it in the dialog and click Submit
9. You'll see your real Instagram data

## Using Demo Data

If you don't want to set up Instagram API:
- Click "Continue with Demo Data" on the login screen
- This will show sample/mock data for demonstration purposes

## Troubleshooting

### "Invalid OAuth Redirect URI"
- Make sure `https://localhost/callback` is added to Valid OAuth Redirect URIs
- The URI must match exactly (including https://)

### "Error getting access token"
- Check that App ID and App Secret are correct
- Make sure your Instagram account is added as a tester
- Check the app is in Development mode

### "Follower/Following count shows 0"
- This is normal! Instagram Basic Display API doesn't provide these counts
- You need Instagram Graph API with a Business account for this data
- Posts count will show correctly

## Data Available

With Instagram Basic Display API, you can access:
- Username
- Account type (Personal/Business/Creator)
- Media count (number of posts)
- Media items (photos, videos, captions, timestamps)

## Security Notes

- Your Instagram credentials are never stored in this app
- OAuth tokens are stored securely using `flutter_secure_storage`
- All authentication happens through Instagram's official OAuth flow
- The app only requests permissions for profile and media data

## Need Help?

- [Instagram Basic Display API Docs](https://developers.facebook.com/docs/instagram-basic-display-api)
- [Facebook App Dashboard](https://developers.facebook.com/apps/)
