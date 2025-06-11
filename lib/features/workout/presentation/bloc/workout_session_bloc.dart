import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/workout_session.dart';
import '../../domain/entities/workout_plan.dart';
import 'package:uuid/uuid.dart';

part 'workout_session_event.dart';
part 'workout_session_state.dart';

class WorkoutSessionBloc
    extends Bloc<WorkoutSessionEvent, WorkoutSessionState> {
  final _uuid = const Uuid();

  WorkoutSessionBloc() : super(WorkoutSessionInitial()) {
    on<StartWorkoutSession>(_onStartWorkoutSession);
    on<UpdateExerciseTarget>(_onUpdateExerciseTarget);
    on<CompleteExerciseSet>(_onCompleteExerciseSet);
    on<EndWorkoutSession>(_onEndWorkoutSession);
    on<CancelWorkoutSession>(_onCancelWorkoutSession);
  }

  void _onStartWorkoutSession(
    StartWorkoutSession event,
    Emitter<WorkoutSessionState> emit,
  ) {
    final exercises = event.workoutPlan.exercises.map((exercise) {
      return ExerciseProgress(
        exerciseId: exercise.id,
        name: exercise.name,
        targetSets: exercise.sets,
        completedSets: 0,
        targetReps: exercise.reps ?? 0,
        targetWeight: exercise.weight,
      );
    }).toList();

    final session = WorkoutSession(
      id: _uuid.v4(),
      workoutPlanId: event.workoutPlan.id,
      memberId: event.workoutPlan.memberId,
      coachId: event.workoutPlan.createdBy,
      startTime: DateTime.now(),
      exerciseProgress: exercises,
      status: WorkoutSessionStatus.inProgress,
    );

    emit(WorkoutSessionActive(session));
  }

  void _onUpdateExerciseTarget(
    UpdateExerciseTarget event,
    Emitter<WorkoutSessionState> emit,
  ) {
    if (state is WorkoutSessionActive) {
      final currentState = state as WorkoutSessionActive;
      final updatedExercises =
          currentState.session.exerciseProgress.map((exercise) {
        if (exercise.exerciseId == event.exerciseId) {
          return exercise.copyWith(
            targetSets: event.targetSets ?? exercise.targetSets,
            targetReps: event.targetReps ?? exercise.targetReps,
            targetWeight: event.targetWeight ?? exercise.targetWeight,
          );
        }
        return exercise;
      }).toList();

      final updatedSession = currentState.session.copyWith(
        exerciseProgress: updatedExercises,
      );

      emit(WorkoutSessionActive(updatedSession));
    }
  }

  void _onCompleteExerciseSet(
    CompleteExerciseSet event,
    Emitter<WorkoutSessionState> emit,
  ) {
    if (state is WorkoutSessionActive) {
      final currentState = state as WorkoutSessionActive;
      final updatedExercises =
          currentState.session.exerciseProgress.map((exercise) {
        if (exercise.exerciseId == event.exerciseId) {
          final newCompletedSets = exercise.completedSets + 1;
          return exercise.copyWith(
            completedSets: newCompletedSets,
            actualWeight: event.actualWeight ?? exercise.actualWeight,
            notes: event.notes ?? exercise.notes,
            isCompleted: newCompletedSets >= exercise.targetSets,
          );
        }
        return exercise;
      }).toList();

      final updatedSession = currentState.session.copyWith(
        exerciseProgress: updatedExercises,
      );

      emit(WorkoutSessionActive(updatedSession));
    }
  }

  void _onEndWorkoutSession(
    EndWorkoutSession event,
    Emitter<WorkoutSessionState> emit,
  ) {
    if (state is WorkoutSessionActive) {
      final currentState = state as WorkoutSessionActive;
      final endTime = DateTime.now();
      final duration =
          endTime.difference(currentState.session.startTime).inMinutes;

      final updatedSession = currentState.session.copyWith(
        endTime: endTime,
        status: WorkoutSessionStatus.completed,
        duration: duration,
        caloriesBurned: event.caloriesBurned,
      );

      emit(WorkoutSessionCompleted(updatedSession));
    }
  }

  void _onCancelWorkoutSession(
    CancelWorkoutSession event,
    Emitter<WorkoutSessionState> emit,
  ) {
    if (state is WorkoutSessionActive) {
      final currentState = state as WorkoutSessionActive;
      final endTime = DateTime.now();
      final duration =
          endTime.difference(currentState.session.startTime).inMinutes;

      final updatedSession = currentState.session.copyWith(
        endTime: endTime,
        status: WorkoutSessionStatus.cancelled,
        duration: duration,
      );

      emit(WorkoutSessionCancelled(updatedSession));
    }
  }
}
