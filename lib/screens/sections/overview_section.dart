import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/sample_data.dart';
import '../../services/instagram_data_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/animated_counter.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/radial_percentage.dart';

class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InstagramDataProvider>(
      builder: (context, provider, _) {
        final hasRealData = provider.hasRealData;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Analyze', style: Theme.of(context).textTheme.headlineLarge),
                      const SizedBox(height: 4),
                      const Text('Your overall engagement health, calculated from recent activity.',
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: hasRealData ? AppColors.green.withOpacity(0.15) : AppColors.orange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: hasRealData ? AppColors.green.withOpacity(0.3) : AppColors.orange.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        hasRealData ? Icons.check_circle : Icons.info_outline,
                        size: 14,
                        color: hasRealData ? AppColors.green : AppColors.orange,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        hasRealData ? 'Real Data' : 'Demo Data',
                        style: TextStyle(
                          color: hasRealData ? AppColors.green : AppColors.orange,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
        LayoutBuilder(
          builder: (context, c) {
            final wide = c.maxWidth > 640;
            final gauge = Center(child: RadialPercentage(percent: SampleData.analyzePercent));
            final info = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                _InfoRow(label: 'Real engagement', value: 'Excellent', color: AppColors.green),
                SizedBox(height: 12),
                _InfoRow(label: 'Ghost followers', value: 'Low', color: AppColors.blue),
                SizedBox(height: 12),
                _InfoRow(label: 'Risk score', value: 'Minimal', color: AppColors.orange),
              ],
            );
            return GlassCard(
              padding: const EdgeInsets.all(26),
              borderGlow: AppColors.purplePinkGradient.scale(0.15),
              child: wide
                  ? Row(children: [gauge, const SizedBox(width: 36), Expanded(child: info)])
                  : Column(children: [gauge, const SizedBox(height: 24), info]),
            );
          },
        ),
            const SizedBox(height: 30),
            Text('Account Stats', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 14),
            LayoutBuilder(
              builder: (context, c) {
                final cols = c.maxWidth > 700 ? 3 : (c.maxWidth > 420 ? 2 : 1);

                // Use real data if available, otherwise use sample data
                final postsCount = hasRealData ? provider.postsCount : SampleData.posts;
                final followersCount = hasRealData ? provider.followersCount : SampleData.followers;
                final followingCount = hasRealData ? provider.followingCount : SampleData.following;

                final stats = [
                  _StatData('Posts', postsCount, Icons.grid_on_rounded, AppColors.purplePinkGradient),
                  _StatData('Followers', followersCount, Icons.group_rounded, AppColors.blueGradient),
                  _StatData('Following', followingCount, Icons.person_add_alt_1_rounded, AppColors.greenGradient),
                ];
                return GridView.count(
                  crossAxisCount: cols,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: cols == 1 ? 2.6 : 1.5,
                  children: stats.map((s) => _StatCard(data: s)).toList(),
                );
              },
            ),
            if (hasRealData && (provider.followersCount == 0 || provider.followingCount == 0)) ...[
              const SizedBox(height: 16),
              GlassCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: const [
                    Icon(Icons.info_outline, color: AppColors.blue, size: 18),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Note: Follower/Following counts require Instagram Graph API with a Business account. Currently showing Posts count only.',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _InfoRow({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13.5)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(color: color.withOpacity(0.16), borderRadius: BorderRadius.circular(8)),
          child: Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 12.5)),
        ),
      ],
    );
  }
}

class _StatData {
  final String label;
  final int value;
  final IconData icon;
  final Gradient gradient;
  _StatData(this.label, this.value, this.icon, this.gradient);
}

class _StatCard extends StatelessWidget {
  final _StatData data;
  const _StatCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(gradient: data.gradient, borderRadius: BorderRadius.circular(14)),
            child: Icon(data.icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedCounter(value: data.value),
                const SizedBox(height: 2),
                Text(data.label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
