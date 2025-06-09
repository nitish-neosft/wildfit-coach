import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../domain/entities/workout_plan.dart';
import '../bloc/workout_bloc.dart';
import '../widgets/workout_plan_card.dart';

class WorkoutPlansScreen extends StatelessWidget {
  final String memberId;

  const WorkoutPlansScreen({
    Key? key,
    required this.memberId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Plans'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                context.push('/workout-plans/new', extra: memberId),
          ),
        ],
      ),
      body: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          if (state is WorkoutLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WorkoutError) {
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
                      context
                          .read<WorkoutBloc>()
                          .add(LoadMemberWorkoutPlans(memberId));
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else if (state is WorkoutPlansLoaded) {
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
                      onPressed: () =>
                          context.push('/workout-plans/new', extra: memberId),
                      child: const Text('Create Workout Plan'),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.workoutPlans.length,
              itemBuilder: (context, index) {
                final plan = state.workoutPlans[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: WorkoutPlanCard(
                    workoutPlan: plan,
                    onTap: () => context.push(
                      '/workout-plans/detail/${plan.id}',
                      extra: {'memberId': memberId, 'plan': plan},
                    ),
                    onEdit: () => context.push(
                      '/workout-plans/${plan.id}/edit',
                      extra: {'memberId': memberId, 'plan': plan},
                    ),
                    onDelete: () => _showDeleteConfirmation(context, plan),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
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
