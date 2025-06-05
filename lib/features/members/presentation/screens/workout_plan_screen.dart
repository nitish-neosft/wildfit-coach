import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/workout_plan.dart';
import '../bloc/workout_plan/workout_plan_bloc.dart';
import '../bloc/workout_plan/workout_plan_state.dart';
import '../bloc/workout_plan/workout_plan_event.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/di/injection_container.dart';

class WorkoutPlanScreen extends StatelessWidget {
  final String memberId;
  final String planId;

  const WorkoutPlanScreen({
    super.key,
    required this.memberId,
    required this.planId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WorkoutPlanBloc>()
        ..add(LoadWorkoutPlan(
          planId: planId,
          memberId: memberId,
        )),
      child: BlocBuilder<WorkoutPlanBloc, WorkoutPlanState>(
        builder: (context, state) {
          if (state is WorkoutPlanLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is WorkoutPlanLoaded) {
            final plan = state.plan;
            return Scaffold(
              appBar: AppBar(
                title: Text(plan.name),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // TODO: Implement edit workout plan
                    },
                  ),
                ],
              ),
              body: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildPlanOverview(plan),
                  const SizedBox(height: 24),
                  _buildWorkoutSchedule(plan),
                  const SizedBox(height: 24),
                  _buildExerciseList(context, plan),
                ],
              ),
            );
          }

          if (state is WorkoutPlanError) {
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
      ),
    );
  }

  Widget _buildPlanOverview(WorkoutPlan plan) {
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
              icon: Icons.fitness_center,
              label: 'Type',
              value: plan.type,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              icon: Icons.timer,
              label: 'Duration',
              value: '${plan.durationWeeks} weeks',
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              icon: Icons.calendar_today,
              label: 'Sessions per week',
              value: '${plan.sessionsPerWeek} sessions',
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              icon: Icons.star,
              label: 'Difficulty',
              value: ((plan.goals?['difficulty'] as String?) ?? 'beginner')
                  .toUpperCase(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutSchedule(WorkoutPlan plan) {
    final sessions = plan.sessions;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Schedule',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Text(
                      'D${session.dayOfWeek}',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(session.name),
                  subtitle: Text(session.type),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Navigate to day detail
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseList(BuildContext context, WorkoutPlan plan) {
    final allExercises = plan.sessions.expand((s) => s.exercises).toList();

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
                  'Exercises',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // TODO: Implement add exercise
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Exercise'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: allExercises.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final exercise = allExercises[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.primary.withOpacity(0.1),
                            child: Icon(
                              Icons.fitness_center,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exercise.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  exercise.type,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, size: 20),
                            onPressed: () {
                              // TODO: Implement edit exercise
                            },
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, size: 20),
                            onPressed: () {
                              context
                                  .read<WorkoutPlanBloc>()
                                  .add(DeleteExercise(
                                    planId: plan.id,
                                    exerciseId: exercise.id,
                                  ));
                            },
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        children: [
                          _buildExerciseDetail(
                            icon: Icons.repeat,
                            label: '${exercise.sets} sets',
                          ),
                          _buildExerciseDetail(
                            icon: Icons.fitness_center,
                            label: '${exercise.reps} reps',
                          ),
                          if (exercise.weight != null)
                            _buildExerciseDetail(
                              icon: Icons.monitor_weight,
                              label: '${exercise.weight} kg',
                            ),
                          if (exercise.duration != null)
                            _buildExerciseDetail(
                              icon: Icons.timer,
                              label: '${exercise.duration!.inSeconds}s',
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseDetail({
    required IconData icon,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
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
