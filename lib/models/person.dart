import 'package:flutter/material.dart';

/// Simple model representing an Instagram-style profile used across
/// the various list sections (visitors, blockers, stalkers, etc).
class Person {
  final String username;
  final String fullName;
  final String initials;
  final Color avatarColor;
  final bool isVerified;
  final String meta; // e.g. "2h ago", "Followed since Jan"

  const Person({
    required this.username,
    required this.fullName,
    required this.initials,
    required this.avatarColor,
    this.isVerified = false,
    this.meta = '',
  });
}
