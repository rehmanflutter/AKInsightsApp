import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_gradient_background.dart';
import '../services/instagram_data_provider.dart';
import '../services/secure_storage_service.dart';
import 'sections/overview_section.dart';
import 'sections/stalk_section.dart';
import 'sections/followers_change_section.dart';
import 'sections/not_following_section.dart';
import 'login_screen.dart';

class _NavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  const _NavItem(this.label, this.icon, this.activeIcon);
}

const _navItems = [
  _NavItem('Overview', Icons.dashboard_outlined, Icons.dashboard_rounded),
  _NavItem('Stalk Insights', Icons.visibility_outlined, Icons.visibility_rounded),
  _NavItem('Follower Activity', Icons.swap_vert_circle_outlined, Icons.swap_vert_circle_rounded),
  _NavItem('Not Following', Icons.person_off_outlined, Icons.person_off_rounded),
];

class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  int _index = 0;

  static const _sections = [
    OverviewSection(),
    StalkSection(),
    FollowersChangeSection(),
    NotFollowingSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientBackground(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            return Row(
              children: [
                if (isWide) _SideRail(index: _index, onTap: (i) => setState(() => _index = i)),
                Expanded(
                  child: Column(
                    children: [
                      _TopBar(isWide: isWide),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 320),
                          transitionBuilder: (child, anim) => FadeTransition(
                            opacity: anim,
                            child: SlideTransition(
                              position: Tween<Offset>(begin: const Offset(0, 0.03), end: Offset.zero)
                                  .animate(anim),
                              child: child,
                            ),
                          ),
                          child: SingleChildScrollView(
                            key: ValueKey(_index),
                            padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 920),
                              child: _sections[_index],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth >= 900
              ? const SizedBox.shrink()
              : _BottomNav(index: _index, onTap: (i) => setState(() => _index = i));
        },
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final bool isWide;
  const _TopBar({required this.isWide});

  void _showProfileMenu(BuildContext context, InstagramDataProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (provider.hasRealData) ...[
              ListTile(
                leading: const Icon(Icons.person, color: AppColors.textPrimary),
                title: Text(provider.user?.username ?? 'User',
                  style: const TextStyle(color: AppColors.textPrimary)),
                subtitle: const Text('Instagram Account',
                  style: TextStyle(color: AppColors.textSecondary)),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.refresh, color: AppColors.blue),
                title: const Text('Refresh Data', style: TextStyle(color: AppColors.textPrimary)),
                onTap: () {
                  Navigator.pop(context);
                  provider.refresh();
                },
              ),
            ],
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(context);
                await provider.logout();
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InstagramDataProvider>(
      builder: (context, provider, _) {
        final username = provider.user?.username ?? 'Demo User';
        final firstLetter = username.isNotEmpty ? username[0].toUpperCase() : 'D';

        return Padding(
          padding: EdgeInsets.fromLTRB(isWide ? 8 : 20, 18, 20, 4),
          child: Row(
            children: [
              if (!isWide) ...[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(gradient: AppColors.brandGradient, borderRadius: BorderRadius.circular(11)),
                  child: const Icon(Icons.insights_rounded, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 10),
                const Text('AK Insights',
                    style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w800, fontSize: 17)),
              ],
              const Spacer(),
              GestureDetector(
                onTap: () => _showProfileMenu(context, provider),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.08)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: provider.hasRealData ? AppColors.green : AppColors.purple,
                        child: Text(firstLetter, style: const TextStyle(fontSize: 11, color: Colors.white)),
                      ),
                      const SizedBox(width: 8),
                      Text(username, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_drop_down, color: AppColors.textSecondary, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SideRail extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;
  const _SideRail({required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.45),
        border: Border(right: BorderSide(color: Colors.white.withOpacity(0.06))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 28),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(gradient: AppColors.brandGradient, borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.insights_rounded, color: Colors.white, size: 19),
                ),
                const SizedBox(width: 10),
                const Text('AK Insights',
                    style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w800, fontSize: 16)),
              ],
            ),
          ),
          for (int i = 0; i < _navItems.length; i++)
            _RailTile(item: _navItems[i], selected: i == index, onTap: () => onTap(i)),
        ],
      ),
    );
  }
}

class _RailTile extends StatefulWidget {
  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;
  const _RailTile({required this.item, required this.selected, required this.onTap});

  @override
  State<_RailTile> createState() => _RailTileState();
}

class _RailTileState extends State<_RailTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.selected;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            gradient: active ? AppColors.brandGradient : null,
            color: !active && _hover ? Colors.white.withOpacity(0.05) : null,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            children: [
              Icon(active ? widget.item.activeIcon : widget.item.icon,
                  color: active ? Colors.white : AppColors.textSecondary, size: 19),
              const SizedBox(width: 12),
              Text(widget.item.label,
                  style: TextStyle(
                    color: active ? Colors.white : AppColors.textSecondary,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 13.5,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;
  const _BottomNav({required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.92),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.06))),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: List.generate(_navItems.length, (i) {
          final active = i == index;
          final item = _navItems[i];
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(i),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(active ? item.activeIcon : item.icon,
                      color: active ? AppColors.magenta : AppColors.textFaint, size: 22),
                  const SizedBox(height: 3),
                  Text(item.label.split(' ')[0],
                      style: TextStyle(
                        color: active ? AppColors.magenta : AppColors.textFaint,
                        fontSize: 10.5,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                      )),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
