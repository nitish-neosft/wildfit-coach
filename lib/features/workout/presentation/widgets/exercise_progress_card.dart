import 'package:flutter/material.dart';
import '../../domain/entities/workout_session.dart';

class ExerciseProgressCard extends StatelessWidget {
  final ExerciseProgress exercise;
  final Function(int? sets, int? reps, double? weight) onUpdateTarget;
  final Function(double? weight, String? notes) onCompleteSet;

  const ExerciseProgressCard({
    Key? key,
    required this.exercise,
    required this.onUpdateTarget,
    required this.onCompleteSet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = (exercise.completedSets / exercise.targetSets) * 100;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: exercise.isCompleted
              ? Colors.green.withOpacity(0.5)
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.name,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (exercise.notes != null && exercise.notes!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            exercise.notes!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (!exercise.isCompleted)
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditTargetDialog(context),
                    tooltip: 'Edit targets',
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildProgressBar(context, progress),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMetricComparison(
                      context,
                      'Sets',
                      exercise.completedSets,
                      exercise.targetSets,
                    ),
                    _buildMetricComparison(
                      context,
                      'Reps',
                      exercise.targetReps,
                      exercise.targetReps,
                      showProgress: false,
                    ),
                    if (exercise.targetWeight != null)
                      _buildMetricComparison(
                        context,
                        'Weight',
                        exercise.actualWeight?.toInt() ?? 0,
                        exercise.targetWeight?.toInt() ?? 0,
                        unit: 'kg',
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                if (!exercise.isCompleted)
                  ElevatedButton.icon(
                    onPressed: () => _showCompleteSetDialog(context),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.check),
                    label: const Text('Complete Set'),
                  ),
                if (exercise.isCompleted)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Exercise Completed',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
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

  Widget _buildProgressBar(BuildContext context, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              '${progress.toInt()}%',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress / 100,
            minHeight: 8,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricComparison(
    BuildContext context,
    String label,
    int current,
    int target, {
    bool showProgress = true,
    String? unit,
  }) {
    final theme = Theme.of(context);
    final isCompleted = !showProgress || current >= target;
    final progressColor = isCompleted ? Colors.green : theme.primaryColor;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: progressColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: progressColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: '$current',
                  style: TextStyle(
                    color: progressColor,
                  ),
                ),
                TextSpan(
                  text: '/$target',
                  style: TextStyle(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
                if (unit != null)
                  TextSpan(
                    text: ' $unit',
                    style: theme.textTheme.bodySmall,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditTargetDialog(BuildContext context) {
    int? sets = exercise.targetSets;
    int? reps = exercise.targetReps;
    double? weight = exercise.targetWeight;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Exercise Target'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Sets',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              controller: TextEditingController(text: sets.toString()),
              onChanged: (value) => sets = int.tryParse(value),
            ),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Reps',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              controller: TextEditingController(text: reps.toString()),
              onChanged: (value) => reps = int.tryParse(value),
            ),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              controller: TextEditingController(
                text: weight?.toString() ?? '',
              ),
              onChanged: (value) => weight = double.tryParse(value),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              onUpdateTarget(sets, reps, weight);
              Navigator.of(context).pop();
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

  void _showCompleteSetDialog(BuildContext context) {
    double? weight = exercise.actualWeight ?? exercise.targetWeight;
    String? notes;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Complete Set'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (exercise.targetWeight != null)
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                controller: TextEditingController(
                  text: weight?.toString() ?? '',
                ),
                onChanged: (value) => weight = double.tryParse(value),
              ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Notes (optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 2,
              onChanged: (value) => notes = value,
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              onCompleteSet(weight, notes);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Complete'),
          ),
        ],
      ),
    );
  }
}
