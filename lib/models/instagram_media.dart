/// Model for Instagram media (posts) from the API
class InstagramMedia {
  final String id;
  final String? caption;
  final String mediaType; // IMAGE, VIDEO, CAROUSEL_ALBUM
  final String? mediaUrl;
  final String? thumbnailUrl;
  final String? permalink;
  final DateTime? timestamp;
  final String? username;

  InstagramMedia({
    required this.id,
    this.caption,
    required this.mediaType,
    this.mediaUrl,
    this.thumbnailUrl,
    this.permalink,
    this.timestamp,
    this.username,
  });

  factory InstagramMedia.fromJson(Map<String, dynamic> json) {
    return InstagramMedia(
      id: json['id'].toString(),
      caption: json['caption'],
      mediaType: json['media_type'] ?? 'IMAGE',
      mediaUrl: json['media_url'],
      thumbnailUrl: json['thumbnail_url'],
      permalink: json['permalink'],
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'])
          : null,
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'caption': caption,
      'media_type': mediaType,
      'media_url': mediaUrl,
      'thumbnail_url': thumbnailUrl,
      'permalink': permalink,
      'timestamp': timestamp?.toIso8601String(),
      'username': username,
    };
  }

  String get displayUrl {
    if (mediaType == 'VIDEO' && thumbnailUrl != null) {
      return thumbnailUrl!;
    }
    return mediaUrl ?? '';
  }
}
