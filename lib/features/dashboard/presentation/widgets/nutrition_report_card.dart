import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class NutritionReportCard extends StatelessWidget {
  final String title;
  final String clientName;
  final int daysRemaining;

  const NutritionReportCard({
    super.key,
    required this.title,
    required this.clientName,
    required this.daysRemaining,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.restaurant_menu,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Client: $clientName',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$daysRemaining days remaining',
                    style: TextStyle(
                      fontSize: 14,
                      color: daysRemaining <= 3
                          ? AppColors.warning
                          : Colors.grey[600],
                      fontWeight: daysRemaining <= 3
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      // TODO: Implement edit nutrition plan
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
