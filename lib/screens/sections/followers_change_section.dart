import 'package:flutter/material.dart';
import '../../data/sample_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/user_list_section.dart';

class FollowersChangeSection extends StatefulWidget {
  const FollowersChangeSection({super.key});

  @override
  State<FollowersChangeSection> createState() => _FollowersChangeSectionState();
}

class _FollowersChangeSectionState extends State<FollowersChangeSection>
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
        Text('Follower Activity', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 4),
        const Text('Track who recently followed or unfollowed you.',
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
            indicator: BoxDecoration(borderRadius: BorderRadius.circular(12), gradient: AppColors.greenGradient),
            labelColor: Colors.white,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            tabs: const [
              Tab(height: 42, child: Text('+ Followers Gained')),
              Tab(height: 42, child: Text('Followers Lost')),
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
                title: 'Followers Gained',
                subtitle: 'New people who started following you',
                icon: Icons.trending_up_rounded,
                gradient: AppColors.greenGradient,
                people: SampleData.followersGained,
                tileIcon: Icons.add_circle_outline_rounded,
                tileIconColor: AppColors.green,
              ),
              UserListSection(
                title: 'Followers Lost',
                subtitle: 'People who unfollowed you recently',
                icon: Icons.trending_down_rounded,
                gradient: AppColors.redGradient,
                people: SampleData.followersLost,
                tileIcon: Icons.remove_circle_outline_rounded,
                tileIconColor: AppColors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
