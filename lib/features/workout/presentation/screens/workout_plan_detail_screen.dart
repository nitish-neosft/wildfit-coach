import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../domain/entities/workout_plan.dart';
import '../../domain/entities/exercise.dart';
import '../bloc/workout_bloc.dart';

class WorkoutPlanDetailScreen extends StatelessWidget {
  final String memberId;
  final WorkoutPlan workoutPlan;

  const WorkoutPlanDetailScreen({
    Key? key,
    required this.memberId,
    required this.workoutPlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workoutPlan.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push(
              '/workout-plans/${workoutPlan.id}/edit',
              extra: {'memberId': memberId, 'plan': workoutPlan},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildExercisesList(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push(
            '/workout-plans/${workoutPlan.id}/workout-session',
            extra: {'plan': workoutPlan},
          );
        },
        icon: const Icon(Icons.fitness_center),
        label: const Text('Start Workout'),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            workoutPlan.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.darkGrey,
                ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildInfoCard(
                context,
                'Type',
                workoutPlan.type.name.toUpperCase(),
                Icons.category,
              ),
              const SizedBox(width: 16),
              _buildInfoCard(
                context,
                'Sessions',
                '${workoutPlan.sessionsPerWeek}/week',
                Icons.calendar_today,
              ),
              const SizedBox(width: 16),
              _buildInfoCard(
                context,
                'Progress',
                '${(workoutPlan.progress * 100).toInt()}%',
                Icons.trending_up,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.darkGrey,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExercisesList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Exercises',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton.icon(
                onPressed: () {
                  // TODO: Add exercise
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Exercise'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: workoutPlan.exercises.length,
            itemBuilder: (context, index) {
              final exercise = workoutPlan.exercises[index];
              return _buildExerciseCard(context, exercise, index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(
      BuildContext context, Exercise exercise, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Text(
            '${index + 1}',
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          exercise.name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          '${exercise.sets} sets × ${exercise.reps} reps',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.darkGrey,
              ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildExerciseDetail(
                      context,
                      'Weight',
                      exercise.weight != null
                          ? '${exercise.weight} kg'
                          : 'Bodyweight',
                    ),
                    _buildExerciseDetail(
                      context,
                      'Rest',
                      '${exercise.restTime} sec',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseDetail(
    BuildContext context,
    String label,
    String value,
  ) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.darkGrey,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
