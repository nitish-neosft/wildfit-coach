import 'package:flutter/material.dart';
import 'package:wildfit_coach/features/members/domain/models/activity.dart';
import '../../../../../core/constants/colors.dart';
import '../../../domain/models/member.dart';

class MembershipDetailsCard extends StatelessWidget {
  final Member member;

  const MembershipDetailsCard({
    super.key,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Membership Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getMembershipStatusColor(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getMembershipStatus(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildDetailRow(
                icon: Icons.person,
                label: 'Trainer',
                value: member.trainerName ?? 'Not Assigned',
              ),
              const SizedBox(height: 12),
              _buildDetailRow(
                icon: Icons.calendar_today,
                label: 'Membership Expires',
                value: _formatDate(member.membershipExpiryDate),
              ),
              const SizedBox(height: 12),
              _buildDetailRow(
                icon: Icons.timer,
                label: 'Last Check-in',
                value: _formatDateTime(member.lastCheckIn),
              ),
              const SizedBox(height: 12),
              _buildDetailRow(
                icon: Icons.calendar_month,
                label: 'Days Present this Month',
                value: '${member.daysPresent ?? 0} days',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  IconData _getActivityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.workout:
        return Icons.fitness_center;
      case ActivityType.cardio:
        return Icons.directions_run;
      case ActivityType.class_:
        return Icons.group;
      case ActivityType.assessment:
        return Icons.assessment;
    }
  }

  Color _getMembershipStatusColor() {
    final daysLeft =
        member.membershipExpiryDate.difference(DateTime.now()).inDays;
    if (daysLeft < 0) return AppColors.error;
    if (daysLeft < 30) return AppColors.warning;
    return AppColors.success;
  }

  String _getMembershipStatus() {
    final daysLeft =
        member.membershipExpiryDate.difference(DateTime.now()).inDays;
    if (daysLeft < 0) return 'Expired';
    if (daysLeft < 30) return '$daysLeft days left';
    return 'Active';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'Never';
    if (dateTime.day == DateTime.now().day) {
      return 'Today at ${_formatTime(dateTime)}';
    }
    return '${_formatDate(dateTime)} at ${_formatTime(dateTime)}';
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
