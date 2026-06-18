import 'package:flutter/material.dart';
import '../models/person.dart';
import '../theme/app_theme.dart';
import 'glass_card.dart';
import 'person_tile.dart';

/// Reusable "list of people" section with a gradient icon header,
/// count badge, and an animated, scrollable list of [PersonTile]s.
/// Reused for: Profile Visitors, Who Blocked Me, Secret Stalkers,
/// Followers Gained/Lost, Not Following Back, Not My Followers, etc.
class UserListSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Gradient gradient;
  final List<Person> people;
  final IconData tileIcon;
  final Color tileIconColor;

  const UserListSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.people,
    this.tileIcon = Icons.chevron_right_rounded,
    this.tileIconColor = AppColors.textFaint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: gradient),
              child: Icon(icon, color: Colors.white, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 2),
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('${people.length}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Expanded(
          child: GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: people.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: Text('Nothing here yet', style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: people.length,
                    itemBuilder: (context, i) => PersonTile(
                      person: people[i],
                      index: i,
                      trailingIcon: tileIcon,
                      trailingColor: tileIconColor,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
