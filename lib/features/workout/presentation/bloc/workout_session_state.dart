part of 'workout_session_bloc.dart';

abstract class WorkoutSessionState extends Equatable {
  const WorkoutSessionState();

  @override
  List<Object?> get props => [];
}

class WorkoutSessionInitial extends WorkoutSessionState {}

class WorkoutSessionActive extends WorkoutSessionState {
  final WorkoutSession session;

  const WorkoutSessionActive(this.session);

  @override
  List<Object?> get props => [session];
}

class WorkoutSessionCompleted extends WorkoutSessionState {
  final WorkoutSession session;

  const WorkoutSessionCompleted(this.session);

  @override
  List<Object?> get props => [session];
}

class WorkoutSessionCancelled extends WorkoutSessionState {
  final WorkoutSession session;

  const WorkoutSessionCancelled(this.session);

  @override
  List<Object?> get props => [session];
}

class WorkoutSessionError extends WorkoutSessionState {
  final String message;

  const WorkoutSessionError(this.message);

  @override
  List<Object?> get props => [message];
}
