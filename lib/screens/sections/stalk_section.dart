import 'package:flutter/material.dart';
import '../../data/sample_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/user_list_section.dart';

class StalkSection extends StatefulWidget {
  const StalkSection({super.key});

  @override
  State<StalkSection> createState() => _StalkSectionState();
}

class _StalkSectionState extends State<StalkSection> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const _tabs = ['Watch Secretly', 'Profile Visitors', 'Who Blocked Me', 'Secret Stalkers'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text('Stalk Insights', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 4),
        const Text('See who interacts with your profile behind the scenes.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        const SizedBox(height: 18),
        _GradientTabBar(controller: _tabController, tabs: _tabs),
        const SizedBox(height: 22),
        SizedBox(
          height: 560,
          child: TabBarView(
            controller: _tabController,
            children: [
              UserListSection(
                title: 'Watch Secretly',
                subtitle: 'Stories & posts you viewed without notifying them',
                icon: Icons.remove_red_eye_outlined,
                gradient: AppColors.purplePinkGradient,
                people: SampleData.watchSecretly,
                tileIcon: Icons.play_circle_outline_rounded,
                tileIconColor: AppColors.magenta,
              ),
              UserListSection(
                title: 'Profile Visitors',
                subtitle: 'Accounts that recently viewed your profile',
                icon: Icons.visibility_outlined,
                gradient: AppColors.blueGradient,
                people: SampleData.profileVisitors,
                tileIcon: Icons.person_search_rounded,
                tileIconColor: AppColors.blue,
              ),
              UserListSection(
                title: 'Who Blocked Me',
                subtitle: 'Accounts that appear to have blocked you',
                icon: Icons.block_rounded,
                gradient: AppColors.redGradient,
                people: SampleData.whoBlockedMe,
                tileIcon: Icons.block_rounded,
                tileIconColor: AppColors.red,
              ),
              UserListSection(
                title: 'Secret Stalkers',
                subtitle: 'Profiles that check you out the most',
                icon: Icons.theater_comedy_outlined,
                gradient: AppColors.greenGradient,
                people: SampleData.secretStalkers,
                tileIcon: Icons.bolt_rounded,
                tileIconColor: AppColors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GradientTabBar extends StatelessWidget {
  final TabController controller;
  final List<String> tabs;
  const _GradientTabBar({required this.controller, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.surface.withOpacity(0.55),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: TabBar(
          controller: controller,
          isScrollable: true,
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(borderRadius: BorderRadius.circular(12), gradient: AppColors.brandGradient),
          labelColor: Colors.white,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          tabs: tabs.map((t) => Tab(text: t, height: 42)).toList(),
        ),
      ),
    );
  }
}
