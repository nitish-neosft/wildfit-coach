import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../domain/entities/dashboard_data.dart';

class ModernStatsCard extends StatelessWidget {
  final DashboardStats stats;

  const ModernStatsCard({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Overview',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _buildStatCard(
                context,
                'Active Clients',
                stats.activeClients.toString(),
                Icons.people,
                AppColors.primaryGradient,
              ),
              _buildStatCard(
                context,
                'Assessments',
                stats.assessments.toString(),
                Icons.assessment,
                [AppColors.success, AppColors.success.withOpacity(0.7)],
              ),
              _buildStatCard(
                context,
                'Today\'s Sessions',
                stats.todaySessions.toString(),
                Icons.calendar_today,
                [AppColors.warning, AppColors.warning.withOpacity(0.7)],
              ),
              _buildStatCard(
                context,
                'Client Progress',
                '${stats.clientProgress}%',
                Icons.trending_up,
                [AppColors.info, AppColors.info.withOpacity(0.7)],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    List<Color> gradientColors,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            switch (title) {
              case 'Active Clients':
                context.push('/members');
                break;
              case 'Assessments':
                context.push('/assessment/pending');
                break;
              case "Today's Sessions":
                context.push('/schedule');
                break;
              case 'Client Progress':
                context.push('/progress');
                break;
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: AppColors.white,
                  size: 24,
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.white.withOpacity(0.8),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
