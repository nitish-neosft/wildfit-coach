import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wildfit_coach/features/members/domain/entities/member.dart';
import '../../../../core/constants/colors.dart';

class MemberCard extends StatelessWidget {
  final Member member;

  const MemberCard({
    super.key,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: AppColors.darkCard,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/member-details/${member.id}'),
        child: SizedBox(
          width: 280,
          height: 160,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: member.avatar != null
                          ? NetworkImage(member.avatar!)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member.name,
                            style: textTheme.titleSmall?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            member.plan,
                            style: textTheme.labelSmall?.copyWith(
                              color: AppColors.darkGrey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                LinearProgressIndicator(
                  value: member.progress != null ? member.progress! / 100 : 0,
                  backgroundColor: AppColors.darkSurface,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
                const SizedBox(height: 4),
                Text(
                  'Progress: ${member.progress}%',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _InfoItem(
                        title: 'Streak',
                        value: '${member.currentStreak}d',
                        icon: Icons.local_fire_department,
                        color: AppColors.warning,
                      ),
                    ),
                    Expanded(
                      child: _InfoItem(
                        title: 'Next',
                        value: member.nextSession ?? '',
                        icon: Icons.calendar_today,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _InfoItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 14,
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: textTheme.labelMedium?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        Text(
          title,
          style: textTheme.labelSmall?.copyWith(
            color: AppColors.darkGrey,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
