import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../domain/entities/nutrition_plan.dart';
import '../../domain/entities/meal.dart';
import '../widgets/meal_card.dart';

class NutritionPlanDetailScreen extends StatelessWidget {
  final String memberId;
  final NutritionPlan nutritionPlan;

  const NutritionPlanDetailScreen({
    Key? key,
    required this.memberId,
    required this.nutritionPlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: Text(nutritionPlan.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push(
              '/nutrition-plans/${nutritionPlan.id}/edit',
              extra: {'memberId': memberId, 'plan': nutritionPlan},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              'Description',
              Text(nutritionPlan.description),
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              'Daily Targets',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTargetRow(
                    'Calories',
                    '${nutritionPlan.dailyCalorieTarget} kcal',
                    Icons.local_fire_department,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Macronutrients',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  ...nutritionPlan.macroTargets.entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _buildTargetRow(
                        entry.key.toUpperCase(),
                        '${entry.value}g',
                        Icons.pie_chart,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (nutritionPlan.dietaryRestrictions.isNotEmpty)
              _buildSection(
                context,
                'Dietary Restrictions',
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: nutritionPlan.dietaryRestrictions
                      .map(
                        (restriction) => Chip(
                          label: Text(restriction),
                          backgroundColor: AppColors.darkCard,
                        ),
                      )
                      .toList(),
                ),
              ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              'Allowed Foods',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: nutritionPlan.allowedFoods
                    .map(
                      (food) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.success,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(food),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),
            if (nutritionPlan.excludedFoods.isNotEmpty)
              _buildSection(
                context,
                'Excluded Foods',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: nutritionPlan.excludedFoods
                      .map(
                        (food) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.not_interested,
                                color: AppColors.error,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(food),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              'Duration',
              Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 8),
                  Text(
                    _formatDateRange(
                      nutritionPlan.startDate,
                      nutritionPlan.endDate,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMealDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildTargetRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Text(label),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _showAddMealDialog(BuildContext context) {
    // TODO: Implement add meal dialog
  }

  String _formatDateRange(DateTime start, DateTime? end) {
    final startStr = '${start.month}/${start.day}/${start.year}';
    if (end != null) {
      final endStr = '${end.month}/${end.day}/${end.year}';
      return '$startStr - $endStr';
    }
    return 'From $startStr';
  }
}
