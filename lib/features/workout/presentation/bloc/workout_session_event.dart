part of 'workout_session_bloc.dart';

abstract class WorkoutSessionEvent extends Equatable {
  const WorkoutSessionEvent();

  @override
  List<Object?> get props => [];
}

class StartWorkoutSession extends WorkoutSessionEvent {
  final WorkoutPlan workoutPlan;

  const StartWorkoutSession(this.workoutPlan);

  @override
  List<Object?> get props => [workoutPlan];
}

class UpdateExerciseTarget extends WorkoutSessionEvent {
  final String exerciseId;
  final int? targetSets;
  final int? targetReps;
  final double? targetWeight;

  const UpdateExerciseTarget({
    required this.exerciseId,
    this.targetSets,
    this.targetReps,
    this.targetWeight,
  });

  @override
  List<Object?> get props => [exerciseId, targetSets, targetReps, targetWeight];
}

class CompleteExerciseSet extends WorkoutSessionEvent {
  final String exerciseId;
  final double? actualWeight;
  final String? notes;

  const CompleteExerciseSet({
    required this.exerciseId,
    this.actualWeight,
    this.notes,
  });

  @override
  List<Object?> get props => [exerciseId, actualWeight, notes];
}

class EndWorkoutSession extends WorkoutSessionEvent {
  final double? caloriesBurned;

  const EndWorkoutSession({this.caloriesBurned});

  @override
  List<Object?> get props => [caloriesBurned];
}

class CancelWorkoutSession extends WorkoutSessionEvent {}
