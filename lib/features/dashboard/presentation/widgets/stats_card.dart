import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../domain/entities/dashboard_data.dart';

class StatsCard extends StatelessWidget {
  final DashboardStats stats;

  const StatsCard({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkCard,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Today\'s Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _StatItem(
                    title: 'Active\nClients',
                    value: stats.activeClients.toString(),
                    icon: Icons.people,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 16),
                  _StatItem(
                    title: 'Assessments',
                    value: stats.assessments.toString(),
                    icon: Icons.assessment,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: 16),
                  _StatItem(
                    title: 'Today\'s\nSessions',
                    value: stats.todaySessions.toString(),
                    icon: Icons.calendar_today,
                    color: AppColors.warning,
                  ),
                  const SizedBox(width: 16),
                  _StatItem(
                    title: 'Client\nProgress',
                    value: '${stats.clientProgress}%',
                    icon: Icons.trending_up,
                    color: AppColors.info,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.darkGrey,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
