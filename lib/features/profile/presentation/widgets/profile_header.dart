import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String avatar;
  final String role;
  final String specialization;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.avatar,
    required this.role,
    required this.specialization,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(avatar),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkGrey,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            role,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            specialization,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkGrey,
                ),
          ),
        ],
      ),
    );
  }
}
