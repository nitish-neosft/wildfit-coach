import 'package:equatable/equatable.dart';
import '../../../domain/entities/workout_plan.dart';

abstract class WorkoutPlanEvent extends Equatable {
  const WorkoutPlanEvent();

  @override
  List<Object?> get props => [];
}

class LoadWorkoutPlan extends WorkoutPlanEvent {
  final String planId;
  final String memberId;

  const LoadWorkoutPlan({
    required this.planId,
    required this.memberId,
  });

  @override
  List<Object> get props => [planId, memberId];
}

class UpdateWorkoutPlan extends WorkoutPlanEvent {
  final WorkoutPlan plan;

  const UpdateWorkoutPlan(this.plan);

  @override
  List<Object> get props => [plan];
}

class AddExercise extends WorkoutPlanEvent {
  final String planId;
  final String sessionId;
  final Exercise exercise;

  const AddExercise({
    required this.planId,
    required this.sessionId,
    required this.exercise,
  });

  @override
  List<Object> get props => [planId, sessionId, exercise];
}

class UpdateExercise extends WorkoutPlanEvent {
  final String planId;
  final String sessionId;
  final Exercise exercise;

  const UpdateExercise({
    required this.planId,
    required this.sessionId,
    required this.exercise,
  });

  @override
  List<Object> get props => [planId, sessionId, exercise];
}

class DeleteExercise extends WorkoutPlanEvent {
  final String planId;
  final String exerciseId;

  const DeleteExercise({
    required this.planId,
    required this.exerciseId,
  });

  @override
  List<Object> get props => [planId, exerciseId];
}
