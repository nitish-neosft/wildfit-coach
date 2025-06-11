import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../domain/entities/member_nutrition_status.dart';
import '../../../dashboard/presentation/widgets/network_image.dart';

class MemberNutritionList extends StatelessWidget {
  final List<MemberNutritionStatus> members;
  final Function(String memberId) onMemberTap;

  const MemberNutritionList({
    super.key,
    required this.members,
    required this.onMemberTap,
  });

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.people_outline,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'No members need nutrition plans',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.white,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'All members have active nutrition plans',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.white.withOpacity(0.7),
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        return Card(
          color: AppColors.darkCard,
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            onTap: () => onMemberTap(member.memberId),
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: member.profileImage != null
                  ? NetworkImageWithFallback(
                      imageUrl: member.profileImage!,
                      width: 40,
                      height: 40,
                      borderRadius: BorderRadius.circular(20),
                    )
                  : const Icon(Icons.person, color: AppColors.primary),
            ),
            title: Text(
              member.memberName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.white,
                  ),
            ),
            subtitle: member.lastPlanEndDate != null
                ? Text(
                    'Last plan ended: ${_formatDate(member.lastPlanEndDate!)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.white.withOpacity(0.7),
                        ),
                  )
                : Text(
                    'No previous plans',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.white.withOpacity(0.7),
                        ),
                  ),
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.white,
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
