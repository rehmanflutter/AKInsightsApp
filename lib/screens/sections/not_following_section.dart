import 'package:flutter/material.dart';
import '../../data/sample_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/user_list_section.dart';

class NotFollowingSection extends StatefulWidget {
  const NotFollowingSection({super.key});

  @override
  State<NotFollowingSection> createState() => _NotFollowingSectionState();
}

class _NotFollowingSectionState extends State<NotFollowingSection>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        Text('Not Following', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 4),
        const Text('Spot one-sided follow relationships at a glance.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.surface.withOpacity(0.55),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.06)),
          ),
          child: TabBar(
            controller: _tabController,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(borderRadius: BorderRadius.circular(12), gradient: AppColors.purplePinkGradient),
            labelColor: Colors.white,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            tabs: const [
              Tab(height: 42, child: Text('Not Follow Back')),
              Tab(height: 42, child: Text('Not My Followers')),
            ],
          ),
        ),
        const SizedBox(height: 22),
        SizedBox(
          height: 560,
          child: TabBarView(
            controller: _tabController,
            children: [
              UserListSection(
                title: 'Not Following Back',
                subtitle: "People you follow who don't follow you back",
                icon: Icons.person_remove_outlined,
                gradient: AppColors.purplePinkGradient,
                people: SampleData.notFollowingBack,
                tileIcon: Icons.person_remove_outlined,
                tileIconColor: AppColors.magenta,
              ),
              UserListSection(
                title: 'Not My Followers',
                subtitle: "Accounts you follow but aren't in your followers list",
                icon: Icons.no_accounts_outlined,
                gradient: AppColors.blueGradient,
                people: SampleData.notMyFollowers,
                tileIcon: Icons.no_accounts_outlined,
                tileIconColor: AppColors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
