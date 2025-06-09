part of 'workout_bloc.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

class LoadWorkoutPlans extends WorkoutEvent {}

class LoadWorkoutPlanById extends WorkoutEvent {
  final String id;

  const LoadWorkoutPlanById({required this.id});

  @override
  List<Object> get props => [id];
}

class LoadMemberWorkoutPlans extends WorkoutEvent {
  final String memberId;

  const LoadMemberWorkoutPlans(this.memberId);

  @override
  List<Object> get props => [memberId];
}

class CreateNewWorkoutPlan extends WorkoutEvent {
  final WorkoutPlan workoutPlan;

  const CreateNewWorkoutPlan(this.workoutPlan);

  @override
  List<Object> get props => [workoutPlan];
}

class UpdateExistingWorkoutPlan extends WorkoutEvent {
  final WorkoutPlan workoutPlan;

  const UpdateExistingWorkoutPlan(this.workoutPlan);

  @override
  List<Object> get props => [workoutPlan];
}

class DeleteExistingWorkoutPlan extends WorkoutEvent {
  final String id;

  const DeleteExistingWorkoutPlan(this.id);

  @override
  List<Object> get props => [id];
}
