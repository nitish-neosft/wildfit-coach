import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../domain/entities/member.dart';

class MemberAppBar extends StatelessWidget {
  final Member member;

  const MemberAppBar({
    super.key,
    required this.member,
  });

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'Never';
    if (dateTime.day == DateTime.now().day) {
      return 'Today ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
    return '${dateTime.day}/${dateTime.month} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primary,
                AppColors.primary.withOpacity(0.8),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: AppColors.white,
                  child: Text(
                    member.name.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  member.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    member.plan,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatItem(
                      icon: Icons.height,
                      value: '${member.height.toStringAsFixed(1)} cm',
                    ),
                    Container(
                      height: 24,
                      width: 1,
                      color: Colors.white.withOpacity(0.3),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    _buildStatItem(
                      icon: Icons.monitor_weight,
                      value: '${member.weight.toStringAsFixed(1)} kg',
                    ),
                    Container(
                      height: 24,
                      width: 1,
                      color: Colors.white.withOpacity(0.3),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    _buildStatItem(
                      icon: Icons.access_time,
                      value: 'Last: ${_formatDateTime(member.lastCheckIn)}',
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

  Widget _buildStatItem({
    required IconData icon,
    required String value,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
