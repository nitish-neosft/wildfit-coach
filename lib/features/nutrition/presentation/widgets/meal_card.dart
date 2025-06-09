import 'package:flutter/material.dart';
import '../../domain/entities/meal.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;

  const MealCard({
    Key? key,
    required this.meal,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule),
                      const SizedBox(width: 8),
                      Text(
                        meal.scheduledTime,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: meal.isCompleted
                          ? Colors.green.withOpacity(0.1)
                          : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      meal.isCompleted ? 'Completed' : 'Pending',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                meal.isCompleted ? Colors.green : Colors.orange,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                meal.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                meal.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNutrientInfo(
                    context,
                    'Calories',
                    '${meal.calories}',
                    'kcal',
                  ),
                  _buildNutrientInfo(
                    context,
                    'Protein',
                    '${meal.macros['protein']?.toInt() ?? 0}',
                    'g',
                  ),
                  _buildNutrientInfo(
                    context,
                    'Carbs',
                    '${meal.macros['carbs']?.toInt() ?? 0}',
                    'g',
                  ),
                  _buildNutrientInfo(
                    context,
                    'Fats',
                    '${meal.macros['fats']?.toInt() ?? 0}',
                    'g',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutrientInfo(
    BuildContext context,
    String label,
    String value,
    String unit,
  ) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 2),
        Text(
          '$value$unit',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
