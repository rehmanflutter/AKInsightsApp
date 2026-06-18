import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'instagram_config.dart';
import 'secure_storage_service.dart';

/// Service for interacting with Instagram Basic Display API
class InstagramService {
  // Backend proxy URL (for web to avoid CORS)
  static const String proxyUrl = 'http://localhost:3000';

  /// Exchange authorization code for access token
  static Future<Map<String, dynamic>?> getAccessToken(String code) async {
    try {
      if (kIsWeb) {
        // Use proxy server for web to avoid CORS issues
        final response = await http.post(
          Uri.parse('$proxyUrl/api/instagram/token'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'code': code}),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          // Save token and user info
          await SecureStorageService.saveAccessToken(data['access_token']);
          await SecureStorageService.saveUserId(data['user_id'].toString());

          return data;
        } else {
          print('Error getting access token: ${response.statusCode}');
          print('Response: ${response.body}');
          return null;
        }
      } else {
        // Direct API call for mobile (no CORS issues)
        final response = await http.post(
          Uri.parse(InstagramConfig.tokenUrl),
          body: {
            'client_id': InstagramConfig.appId,
            'client_secret': InstagramConfig.appSecret,
            'grant_type': 'authorization_code',
            'redirect_uri': InstagramConfig.redirectUri,
            'code': code,
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          // Save token and user info
          await SecureStorageService.saveAccessToken(data['access_token']);
          await SecureStorageService.saveUserId(data['user_id'].toString());

          return data;
        } else {
          print('Error getting access token: ${response.statusCode}');
          print('Response: ${response.body}');
          return null;
        }
      }
    } catch (e) {
      print('Exception getting access token: $e');
      return null;
    }
  }

  /// Get user profile information
  static Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final token = await SecureStorageService.getAccessToken();
      final userId = await SecureStorageService.getUserId();

      if (token == null || userId == null) {
        return null;
      }

      if (kIsWeb) {
        // Use proxy for web
        final response = await http.get(
          Uri.parse('$proxyUrl/api/instagram/profile?accessToken=$token&userId=$userId'),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          await SecureStorageService.saveUsername(data['username']);
          return data;
        } else {
          print('Error getting user profile: ${response.statusCode}');
          print('Response: ${response.body}');
          return null;
        }
      } else {
        // Direct API call for mobile
        final response = await http.get(
          Uri.parse(
            '${InstagramConfig.graphApiUrl}/$userId?fields=id,username,account_type,media_count&access_token=$token',
          ),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          await SecureStorageService.saveUsername(data['username']);
          return data;
        } else {
          print('Error getting user profile: ${response.statusCode}');
          print('Response: ${response.body}');
          return null;
        }
      }
    } catch (e) {
      print('Exception getting user profile: $e');
      return null;
    }
  }

  /// Get user's media (posts)
  static Future<List<dynamic>> getUserMedia({int limit = 25}) async {
    try {
      final token = await SecureStorageService.getAccessToken();
      final userId = await SecureStorageService.getUserId();

      if (token == null || userId == null) {
        return [];
      }

      if (kIsWeb) {
        // Use proxy for web
        final response = await http.get(
          Uri.parse('$proxyUrl/api/instagram/media?accessToken=$token&userId=$userId&limit=$limit'),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          return data['data'] ?? [];
        } else {
          print('Error getting user media: ${response.statusCode}');
          return [];
        }
      } else {
        // Direct API call for mobile
        final response = await http.get(
          Uri.parse(
            '${InstagramConfig.graphApiUrl}/$userId/media?fields=id,caption,media_type,media_url,thumbnail_url,permalink,timestamp,username&limit=$limit&access_token=$token',
          ),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          return data['data'] ?? [];
        } else {
          print('Error getting user media: ${response.statusCode}');
          return [];
        }
      }
    } catch (e) {
      print('Exception getting user media: $e');
      return [];
    }
  }

  /// Get long-lived access token (lasts 60 days instead of 1 hour)
  static Future<String?> getLongLivedToken(String shortLivedToken) async {
    try {
      if (kIsWeb) {
        // Use proxy for web
        final response = await http.get(
          Uri.parse('$proxyUrl/api/instagram/long-lived-token?accessToken=$shortLivedToken'),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final longLivedToken = data['access_token'];

          // Update stored token with long-lived one
          await SecureStorageService.saveAccessToken(longLivedToken);

          return longLivedToken;
        } else {
          print('Error getting long-lived token: ${response.statusCode}');
          return null;
        }
      } else {
        // Direct API call for mobile
        final response = await http.get(
          Uri.parse(
            '${InstagramConfig.graphApiUrl}/access_token?grant_type=ig_exchange_token&client_secret=${InstagramConfig.appSecret}&access_token=$shortLivedToken',
          ),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final longLivedToken = data['access_token'];

          // Update stored token with long-lived one
          await SecureStorageService.saveAccessToken(longLivedToken);

          return longLivedToken;
        } else {
          print('Error getting long-lived token: ${response.statusCode}');
          return null;
        }
      }
    } catch (e) {
      print('Exception getting long-lived token: $e');
      return null;
    }
  }

  /// Refresh long-lived token (extends expiration by 60 days)
  static Future<bool> refreshToken() async {
    try {
      final token = await SecureStorageService.getAccessToken();

      if (token == null) {
        return false;
      }

      final response = await http.get(
        Uri.parse(
          '${InstagramConfig.graphApiUrl}/refresh_access_token?grant_type=ig_refresh_token&access_token=$token',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await SecureStorageService.saveAccessToken(data['access_token']);
        return true;
      } else {
        print('Error refreshing token: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception refreshing token: $e');
      return false;
    }
  }

  /// Logout - clear all stored data
  static Future<void> logout() async {
    await SecureStorageService.clearAll();
  }
}
