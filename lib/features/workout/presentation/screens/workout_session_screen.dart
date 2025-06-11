import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/workout_plan.dart';
import '../../domain/entities/workout_session.dart';
import '../bloc/workout_session_bloc.dart';
import '../widgets/exercise_progress_card.dart';

class WorkoutSessionScreen extends StatelessWidget {
  final WorkoutPlan workoutPlan;

  const WorkoutSessionScreen({
    Key? key,
    required this.workoutPlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WorkoutSessionBloc()..add(StartWorkoutSession(workoutPlan)),
      child: BlocBuilder<WorkoutSessionBloc, WorkoutSessionState>(
        builder: (context, state) {
          if (state is WorkoutSessionActive) {
            return _buildActiveSession(context, state.session);
          } else if (state is WorkoutSessionCompleted) {
            return _buildCompletedSession(context, state.session);
          } else if (state is WorkoutSessionCancelled) {
            return _buildCancelledSession(context, state.session);
          } else if (state is WorkoutSessionError) {
            return _buildErrorState(context, state.message);
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget _buildActiveSession(BuildContext context, WorkoutSession session) {
    final theme = Theme.of(context);
    final duration = DateTime.now().difference(session.startTime);
    final totalExercises = session.exerciseProgress.length;
    final completedExercises = session.exerciseProgress
        .where((exercise) => exercise.isCompleted)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: Text(workoutPlan.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () => _showCancelConfirmation(context),
            tooltip: 'Cancel workout',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSessionStat(
                  context,
                  'Duration',
                  '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                  Icons.timer,
                ),
                _buildSessionStat(
                  context,
                  'Exercises',
                  '$completedExercises/$totalExercises',
                  Icons.fitness_center,
                ),
                _buildSessionStat(
                  context,
                  'Progress',
                  '${((completedExercises / totalExercises) * 100).toInt()}%',
                  Icons.trending_up,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: session.exerciseProgress.length,
              itemBuilder: (context, index) {
                final exercise = session.exerciseProgress[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ExerciseProgressCard(
                    exercise: exercise,
                    onUpdateTarget: (sets, reps, weight) {
                      context.read<WorkoutSessionBloc>().add(
                            UpdateExerciseTarget(
                              exerciseId: exercise.exerciseId,
                              targetSets: sets,
                              targetReps: reps,
                              targetWeight: weight,
                            ),
                          );
                    },
                    onCompleteSet: (weight, notes) {
                      context.read<WorkoutSessionBloc>().add(
                            CompleteExerciseSet(
                              exerciseId: exercise.exerciseId,
                              actualWeight: weight,
                              notes: notes,
                            ),
                          );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context, session),
    );
  }

  Widget _buildSessionStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: theme.primaryColor,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, WorkoutSession session) {
    final allExercisesCompleted =
        session.exerciseProgress.every((exercise) => exercise.isCompleted);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: allExercisesCompleted
              ? () => _showCompletionDialog(context)
              : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            allExercisesCompleted
                ? 'Complete Workout'
                : 'Complete All Exercises to Finish',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildCompletedSession(BuildContext context, WorkoutSession session) {
    final theme = Theme.of(context);
    final duration = session.endTime!.difference(session.startTime);
    final totalSets = session.exerciseProgress
        .fold(0, (sum, exercise) => sum + exercise.completedSets);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_outline,
                    size: 72,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Workout Complete!',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Great job completing ${workoutPlan.name}',
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                _buildCompletionStat(
                  context,
                  'Duration',
                  '${duration.inMinutes} minutes',
                  Icons.timer,
                ),
                const SizedBox(height: 16),
                _buildCompletionStat(
                  context,
                  'Sets Completed',
                  '$totalSets sets',
                  Icons.fitness_center,
                ),
                const SizedBox(height: 16),
                if (session.caloriesBurned != null)
                  _buildCompletionStat(
                    context,
                    'Calories Burned',
                    '${session.caloriesBurned!.toInt()} kcal',
                    Icons.local_fire_department,
                  ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Return to Workouts'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompletionStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.primaryColor),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall,
              ),
              Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCancelledSession(BuildContext context, WorkoutSession session) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.cancel_outlined,
                    size: 72,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Workout Cancelled',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your progress has been saved',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Return to Workouts'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.error_outline,
                    size: 72,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Error',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCancelConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Workout?'),
        content: const Text(
          'Are you sure you want to cancel this workout? Progress will be saved but the workout will be marked as cancelled.',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No, Continue'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<WorkoutSessionBloc>().add(CancelWorkoutSession());
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Complete Workout'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Great job! Would you like to record calories burned?'),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Calories Burned',
                hintText: 'Enter calories burned (optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) {
                final calories = double.tryParse(value);
                context
                    .read<WorkoutSessionBloc>()
                    .add(EndWorkoutSession(caloriesBurned: calories));
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<WorkoutSessionBloc>().add(const EndWorkoutSession());
              Navigator.of(context).pop();
            },
            child: const Text('Skip'),
          ),
          ElevatedButton(
            onPressed: () {
              // Dialog will be closed by onSubmitted of TextField
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
