import 'package:flutter/foundation.dart';
import 'instagram_service.dart';
import 'secure_storage_service.dart';
import '../models/instagram_user.dart';
import '../models/instagram_media.dart';

/// Provider for managing Instagram data state
class InstagramDataProvider extends ChangeNotifier {
  InstagramUser? _user;
  List<InstagramMedia> _media = [];
  bool _isLoading = false;
  bool _isLoggedIn = false;
  String? _error;

  InstagramUser? get user => _user;
  List<InstagramMedia> get media => _media;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String? get error => _error;
  bool get hasRealData => _user != null;

  /// Initialize and check login status
  Future<void> initialize() async {
    _isLoggedIn = await SecureStorageService.isLoggedIn();
    if (_isLoggedIn) {
      await fetchData();
    }
    notifyListeners();
  }

  /// Fetch all Instagram data
  Future<void> fetchData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Fetch user profile
      final userData = await InstagramService.getUserProfile();
      if (userData != null) {
        _user = InstagramUser.fromJson(userData);
        _isLoggedIn = true;
      }

      // Fetch media
      final mediaData = await InstagramService.getUserMedia(limit: 25);
      _media = mediaData.map((m) => InstagramMedia.fromJson(m)).toList();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Refresh data
  Future<void> refresh() async {
    await fetchData();
  }

  /// Logout and clear data
  Future<void> logout() async {
    await InstagramService.logout();
    _user = null;
    _media = [];
    _isLoggedIn = false;
    _error = null;
    notifyListeners();
  }

  /// Get stats for display
  int get postsCount => _user?.mediaCount ?? 0;

  // Note: Instagram Basic Display API doesn't provide follower/following counts
  // These would need Instagram Graph API with a business account
  // For now, return 0 or placeholder values
  int get followersCount => 0; // Not available in Basic Display API
  int get followingCount => 0; // Not available in Basic Display API
}
