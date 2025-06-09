import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../domain/entities/dashboard_data.dart';

class ActivityTimeline extends StatelessWidget {
  final List<DashboardActivity> activities;

  const ActivityTimeline({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        final isLast = index == activities.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _getActivityColor(activity.type),
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: AppColors.darkDivider,
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.darkCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.darkDivider,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _getActivityIcon(activity.type),
                            color: _getActivityColor(activity.type),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            activity.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        activity.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.white.withOpacity(0.7),
                            ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            activity.memberName,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          Text(
                            activity.time,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.white.withOpacity(0.5),
                                    ),
                          ),
                        ],
                      ),
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

  Color _getActivityColor(String type) {
    switch (type.toLowerCase()) {
      case 'assessment':
        return AppColors.success;
      case 'workout':
        return AppColors.warning;
      case 'nutrition':
        return AppColors.info;
      case 'session':
        return AppColors.accent;
      default:
        return AppColors.primary;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type.toLowerCase()) {
      case 'assessment':
        return Icons.assessment;
      case 'workout':
        return Icons.fitness_center;
      case 'nutrition':
        return Icons.restaurant_menu;
      case 'session':
        return Icons.calendar_today;
      default:
        return Icons.circle;
    }
  }
}
