/// Model for Instagram user profile data from the API
class InstagramUser {
  final String id;
  final String username;
  final String accountType;
  final int mediaCount;

  InstagramUser({
    required this.id,
    required this.username,
    required this.accountType,
    required this.mediaCount,
  });

  factory InstagramUser.fromJson(Map<String, dynamic> json) {
    return InstagramUser(
      id: json['id'].toString(),
      username: json['username'] ?? '',
      accountType: json['account_type'] ?? 'PERSONAL',
      mediaCount: json['media_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'account_type': accountType,
      'media_count': mediaCount,
    };
  }
}
