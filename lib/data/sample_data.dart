import 'package:flutter/material.dart';
import '../models/person.dart';

/// NOTE: All data below is placeholder/demo data for UI purposes only.
/// Instagram does not provide an official way to fetch "secret stalkers",
/// "profile visitors" or "who blocked me" — this app is a design template,
/// not a real scraping tool. Wire it up to your own legitimate backend
/// if you build real functionality later.
class SampleData {
  SampleData._();

  static const List<Color> _palette = [
    Color(0xFF8338EC),
    Color(0xFFE5249F),
    Color(0xFFFF8A3D),
    Color(0xFF2D9CFF),
    Color(0xFF2BDB8F),
    Color(0xFFFF4D6D),
    Color(0xFFFFC233),
  ];

  static List<Person> _generate(int count, String prefix, {String meta = ''}) {
    return List.generate(count, (i) {
      final n = i + 1;
      return Person(
        username: '${prefix}_user$n',
        fullName: '$prefix Person $n',
        initials: prefix.substring(0, 1).toUpperCase() + n.toString()[0],
        avatarColor: _palette[i % _palette.length],
        isVerified: i % 5 == 0,
        meta: meta,
      );
    });
  }

  static List<Person> watchSecretly = _generate(8, 'watch', meta: 'Story viewed secretly');
  static List<Person> profileVisitors = _generate(14, 'visit', meta: 'Visited your profile');
  static List<Person> whoBlockedMe = _generate(4, 'block', meta: 'Blocked you');
  static List<Person> secretStalkers = _generate(11, 'stalk', meta: 'Frequently checks your profile');
  static List<Person> followersGained = _generate(23, 'gain', meta: 'Started following you');
  static List<Person> followersLost = _generate(9, 'lost', meta: 'Unfollowed you');
  static List<Person> notFollowingBack = _generate(17, 'nofb', meta: "Doesn't follow you back");
  static List<Person> notMyFollowers = _generate(12, 'nomf', meta: 'You follow • not following you');

  static const int posts = 248;
  static const int followers = 12400;
  static const int following = 980;
  static const int analyzePercent = 91;
}
