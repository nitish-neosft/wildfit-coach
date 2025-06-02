import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wildfit_coach/features/members/domain/models/nutrition_plan.dart';
import '../../../../core/constants/colors.dart';
import '../../bloc/nutrition_plan_bloc.dart';

class NutritionPlanScreen extends StatelessWidget {
  final String memberId;
  final String planId;

  const NutritionPlanScreen({
    super.key,
    required this.memberId,
    required this.planId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NutritionPlanBloc, NutritionPlanState>(
      builder: (context, state) {
        if (state is NutritionPlanLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is NutritionPlanLoaded) {
          final plan = state.plan;
          return Scaffold(
            appBar: AppBar(
              title: Text(plan.name),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // TODO: Implement edit nutrition plan
                  },
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildPlanOverview(plan),
                const SizedBox(height: 24),
                _buildMealSchedule(plan),
                const SizedBox(height: 24),
                _buildNutritionGoals(plan),
                const SizedBox(height: 24),
                _buildSupplements(plan),
              ],
            ),
          );
        }

        if (state is NutritionPlanError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(
            child: Text('Something went wrong'),
          ),
        );
      },
    );
  }

  Widget _buildPlanOverview(NutritionPlan plan) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Plan Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              icon: Icons.restaurant_menu,
              label: 'Type',
              value: plan.type,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              icon: Icons.local_fire_department,
              label: 'Daily Calories',
              value: '${plan.dailyCalories} cal',
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              icon: Icons.schedule,
              label: 'Meals per Day',
              value: '${plan.mealsPerDay} meals',
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              icon: Icons.calendar_today,
              label: 'Duration',
              value: '${plan.durationWeeks} weeks',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealSchedule(NutritionPlan plan) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Meal Schedule',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // TODO: Add new meal
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Meal'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: plan.meals.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final meal = plan.meals[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    meal.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        '${meal.time.format(context)} | ${meal.calories} cal',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 8,
                        children: meal.foods.map((food) {
                          return Chip(
                            label: Text(
                              food,
                              style: const TextStyle(fontSize: 12),
                            ),
                            backgroundColor: Colors.grey[200],
                            visualDensity: VisualDensity.compact,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      // TODO: Show meal options
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionGoals(NutritionPlan plan) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nutrition Goals',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildNutrientProgress(
              'Protein',
              plan.currentProtein,
              plan.targetProtein,
              'g',
              Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildNutrientProgress(
              'Carbs',
              plan.currentCarbs,
              plan.targetCarbs,
              'g',
              Colors.orange,
            ),
            const SizedBox(height: 16),
            _buildNutrientProgress(
              'Fats',
              plan.currentFats,
              plan.targetFats,
              'g',
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientProgress(
    String label,
    double current,
    double target,
    String unit,
    Color color,
  ) {
    final progress = current / target;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$current/$target $unit',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildSupplements(NutritionPlan plan) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Supplements',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // TODO: Add new supplement
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: plan.supplements.length,
              itemBuilder: (context, index) {
                final supplement = plan.supplements[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.medication),
                  title: Text(supplement.name),
                  subtitle: Text(
                    '${supplement.dosage} | ${supplement.timing}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      // TODO: Delete supplement
                    },
                  ),
                );
              },
            ),
          ],
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
}
