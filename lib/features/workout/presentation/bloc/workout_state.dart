part of 'workout_bloc.dart';

abstract class WorkoutState extends Equatable {
  const WorkoutState();

  @override
  List<Object?> get props => [];
}

class WorkoutInitial extends WorkoutState {}

class WorkoutLoading extends WorkoutState {}

class WorkoutPlansLoaded extends WorkoutState {
  final List<WorkoutPlan> workoutPlans;

  const WorkoutPlansLoaded({required this.workoutPlans});

  @override
  List<Object?> get props => [workoutPlans];
}

class WorkoutPlanLoaded extends WorkoutState {
  final WorkoutPlan workoutPlan;

  const WorkoutPlanLoaded({required this.workoutPlan});

  @override
  List<Object?> get props => [workoutPlan];
}

class WorkoutError extends WorkoutState {
  final String message;

  const WorkoutError({required this.message});

  @override
  List<Object?> get props => [message];
}

class WorkoutPlanCreated extends WorkoutState {
  final WorkoutPlan workoutPlan;

  const WorkoutPlanCreated(this.workoutPlan);

  @override
  List<Object?> get props => [workoutPlan];
}

class WorkoutPlanUpdated extends WorkoutState {
  final WorkoutPlan workoutPlan;

  const WorkoutPlanUpdated(this.workoutPlan);

  @override
  List<Object?> get props => [workoutPlan];
}

class WorkoutPlanDeleted extends WorkoutState {}
