import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../domain/entities/workout_plan.dart';
import '../bloc/workout_bloc.dart';
import '../widgets/workout_plan_card.dart';

class WorkoutsOverviewScreen extends StatelessWidget {
  const WorkoutsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts Overview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filtering
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Filtering coming soon'),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          if (state is WorkoutInitial) {
            context.read<WorkoutBloc>().add(LoadWorkoutPlans());
          }

          if (state is WorkoutLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WorkoutError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(color: AppColors.error),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WorkoutBloc>().add(LoadWorkoutPlans());
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          if (state is WorkoutPlansLoaded) {
            if (state.workoutPlans.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'No workout plans yet',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.push('/members'),
                      child: const Text('Add Workout Plan'),
                    ),
                  ],
                ),
              );
            }

            // Group workout plans by type
            final groupedPlans = _groupWorkoutPlansByType(state.workoutPlans);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWorkoutStats(state.workoutPlans),
                    const SizedBox(height: 24),
                    ...groupedPlans.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatWorkoutType(entry.key),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 16),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: entry.value.length,
                            itemBuilder: (context, index) {
                              final plan = entry.value[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: WorkoutPlanCard(
                                  workoutPlan: plan,
                                  onTap: () => context.push(
                                    '/workout-plans/detail/${plan.id}',
                                    extra: {
                                      'memberId': plan.memberId,
                                      'plan': plan
                                    },
                                  ),
                                  onEdit: () => context.push(
                                    '/workout-plans/${plan.id}/edit',
                                    extra: {
                                      'memberId': plan.memberId,
                                      'plan': plan
                                    },
                                  ),
                                  onDelete: () =>
                                      _showDeleteConfirmation(context, plan),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildWorkoutStats(List<WorkoutPlan> plans) {
    final totalPlans = plans.length;
    final activePlans = plans.where((p) => p.isActive).length;
    final uniqueMembers = plans.map((p) => p.memberId).toSet().length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkDivider),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Total Plans', totalPlans.toString()),
          _buildStatItem('Active Plans', activePlans.toString()),
          _buildStatItem('Members', uniqueMembers.toString()),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: AppColors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Map<WorkoutPlanType, List<WorkoutPlan>> _groupWorkoutPlansByType(
      List<WorkoutPlan> plans) {
    final grouped = <WorkoutPlanType, List<WorkoutPlan>>{};
    for (final plan in plans) {
      if (!grouped.containsKey(plan.type)) {
        grouped[plan.type] = [];
      }
      grouped[plan.type]!.add(plan);
    }
    return grouped;
  }

  String _formatWorkoutType(WorkoutPlanType type) {
    return type.toString().split('.').last.toUpperCase();
  }

  Future<void> _showDeleteConfirmation(
      BuildContext context, WorkoutPlan plan) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Workout Plan'),
        content: Text(
            'Are you sure you want to delete "${plan.name}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<WorkoutBloc>().add(DeleteExistingWorkoutPlan(plan.id));
    }
  }
}
