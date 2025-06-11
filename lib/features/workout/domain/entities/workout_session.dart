import 'package:equatable/equatable.dart';
import 'exercise.dart';

enum WorkoutSessionStatus { notStarted, inProgress, completed, cancelled }

class ExerciseProgress extends Equatable {
  final String exerciseId;
  final String name;
  final int targetSets;
  final int completedSets;
  final int targetReps;
  final double? targetWeight;
  final double? actualWeight;
  final String? notes;
  final bool isCompleted;

  const ExerciseProgress({
    required this.exerciseId,
    required this.name,
    required this.targetSets,
    required this.completedSets,
    required this.targetReps,
    this.targetWeight,
    this.actualWeight,
    this.notes,
    this.isCompleted = false,
  });

  ExerciseProgress copyWith({
    String? exerciseId,
    String? name,
    int? targetSets,
    int? completedSets,
    int? targetReps,
    double? targetWeight,
    double? actualWeight,
    String? notes,
    bool? isCompleted,
  }) {
    return ExerciseProgress(
      exerciseId: exerciseId ?? this.exerciseId,
      name: name ?? this.name,
      targetSets: targetSets ?? this.targetSets,
      completedSets: completedSets ?? this.completedSets,
      targetReps: targetReps ?? this.targetReps,
      targetWeight: targetWeight ?? this.targetWeight,
      actualWeight: actualWeight ?? this.actualWeight,
      notes: notes ?? this.notes,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [
        exerciseId,
        name,
        targetSets,
        completedSets,
        targetReps,
        targetWeight,
        actualWeight,
        notes,
        isCompleted,
      ];
}

class WorkoutSession extends Equatable {
  final String id;
  final String workoutPlanId;
  final String memberId;
  final String coachId;
  final DateTime startTime;
  final DateTime? endTime;
  final List<ExerciseProgress> exerciseProgress;
  final WorkoutSessionStatus status;
  final double? caloriesBurned;
  final int? duration;
  final Map<String, dynamic>? metadata;

  const WorkoutSession({
    required this.id,
    required this.workoutPlanId,
    required this.memberId,
    required this.coachId,
    required this.startTime,
    this.endTime,
    required this.exerciseProgress,
    this.status = WorkoutSessionStatus.notStarted,
    this.caloriesBurned,
    this.duration,
    this.metadata,
  });

  WorkoutSession copyWith({
    String? id,
    String? workoutPlanId,
    String? memberId,
    String? coachId,
    DateTime? startTime,
    DateTime? endTime,
    List<ExerciseProgress>? exerciseProgress,
    WorkoutSessionStatus? status,
    double? caloriesBurned,
    int? duration,
    Map<String, dynamic>? metadata,
  }) {
    return WorkoutSession(
      id: id ?? this.id,
      workoutPlanId: workoutPlanId ?? this.workoutPlanId,
      memberId: memberId ?? this.memberId,
      coachId: coachId ?? this.coachId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      exerciseProgress: exerciseProgress ?? this.exerciseProgress,
      status: status ?? this.status,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      duration: duration ?? this.duration,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
        id,
        workoutPlanId,
        memberId,
        coachId,
        startTime,
        endTime,
        exerciseProgress,
        status,
        caloriesBurned,
        duration,
        metadata,
      ];
}
