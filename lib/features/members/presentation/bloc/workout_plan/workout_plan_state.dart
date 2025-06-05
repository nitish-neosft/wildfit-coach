import 'package:equatable/equatable.dart';
import '../../../domain/entities/workout_plan.dart';

abstract class WorkoutPlanState extends Equatable {
  const WorkoutPlanState();

  @override
  List<Object> get props => [];
}

class WorkoutPlanInitial extends WorkoutPlanState {}

class WorkoutPlanLoading extends WorkoutPlanState {}

class WorkoutPlanLoaded extends WorkoutPlanState {
  final WorkoutPlan plan;

  const WorkoutPlanLoaded(this.plan);

  @override
  List<Object> get props => [plan];
}

class WorkoutPlanError extends WorkoutPlanState {
  final String message;

  const WorkoutPlanError(this.message);

  @override
  List<Object> get props => [message];
}
