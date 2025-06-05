import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/workout_plan.dart';
import '../../../domain/repositories/workout_plan_repository.dart';
import 'workout_plan_event.dart';
import 'workout_plan_state.dart';

class WorkoutPlanBloc extends Bloc<WorkoutPlanEvent, WorkoutPlanState> {
  final WorkoutPlanRepository repository;

  WorkoutPlanBloc({
    required this.repository,
  }) : super(WorkoutPlanInitial()) {
    on<LoadWorkoutPlan>(_onLoadWorkoutPlan);
    on<UpdateWorkoutPlan>(_onUpdateWorkoutPlan);
    on<AddExercise>(_onAddExercise);
    on<UpdateExercise>(_onUpdateExercise);
    on<DeleteExercise>(_onDeleteExercise);
  }

  Future<void> _onLoadWorkoutPlan(
    LoadWorkoutPlan event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    try {
      emit(WorkoutPlanLoading());
      final plan = await repository.getWorkoutPlan(event.planId);
      emit(WorkoutPlanLoaded(plan));
    } catch (error) {
      emit(WorkoutPlanError(error.toString()));
    }
  }

  Future<void> _onUpdateWorkoutPlan(
    UpdateWorkoutPlan event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    try {
      emit(WorkoutPlanLoading());
      final plan = await repository.updateWorkoutPlan(event.plan);
      emit(WorkoutPlanLoaded(plan));
    } catch (error) {
      emit(WorkoutPlanError(error.toString()));
    }
  }

  Future<void> _onAddExercise(
    AddExercise event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    if (state is WorkoutPlanLoaded) {
      try {
        final currentPlan = (state as WorkoutPlanLoaded).plan;
        final updatedSessions = currentPlan.sessions.map((session) {
          if (session.id == event.sessionId) {
            return WorkoutSession(
              id: session.id,
              name: session.name,
              type: session.type,
              dayOfWeek: session.dayOfWeek,
              duration: session.duration,
              exercises: [...session.exercises, event.exercise],
              notes: session.notes,
            );
          }
          return session;
        }).toList();

        final updatedPlan = WorkoutPlan(
          id: currentPlan.id,
          memberId: currentPlan.memberId,
          name: currentPlan.name,
          type: currentPlan.type,
          durationWeeks: currentPlan.durationWeeks,
          sessionsPerWeek: currentPlan.sessionsPerWeek,
          sessions: updatedSessions,
          goals: currentPlan.goals,
          progress: currentPlan.progress,
        );

        emit(WorkoutPlanLoading());
        final savedPlan = await repository.updateWorkoutPlan(updatedPlan);
        emit(WorkoutPlanLoaded(savedPlan));
      } catch (error) {
        emit(WorkoutPlanError(error.toString()));
      }
    }
  }

  Future<void> _onUpdateExercise(
    UpdateExercise event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    if (state is WorkoutPlanLoaded) {
      try {
        final currentPlan = (state as WorkoutPlanLoaded).plan;
        final updatedSessions = currentPlan.sessions.map((session) {
          if (session.id == event.sessionId) {
            return WorkoutSession(
              id: session.id,
              name: session.name,
              type: session.type,
              dayOfWeek: session.dayOfWeek,
              duration: session.duration,
              exercises: session.exercises.map((exercise) {
                return exercise.id == event.exercise.id
                    ? event.exercise
                    : exercise;
              }).toList(),
              notes: session.notes,
            );
          }
          return session;
        }).toList();

        final updatedPlan = WorkoutPlan(
          id: currentPlan.id,
          memberId: currentPlan.memberId,
          name: currentPlan.name,
          type: currentPlan.type,
          durationWeeks: currentPlan.durationWeeks,
          sessionsPerWeek: currentPlan.sessionsPerWeek,
          sessions: updatedSessions,
          goals: currentPlan.goals,
          progress: currentPlan.progress,
        );

        emit(WorkoutPlanLoading());
        final savedPlan = await repository.updateWorkoutPlan(updatedPlan);
        emit(WorkoutPlanLoaded(savedPlan));
      } catch (error) {
        emit(WorkoutPlanError(error.toString()));
      }
    }
  }

  Future<void> _onDeleteExercise(
    DeleteExercise event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    if (state is WorkoutPlanLoaded) {
      try {
        final currentPlan = (state as WorkoutPlanLoaded).plan;
        final updatedSessions = currentPlan.sessions.map((session) {
          return WorkoutSession(
            id: session.id,
            name: session.name,
            type: session.type,
            dayOfWeek: session.dayOfWeek,
            duration: session.duration,
            exercises: session.exercises
                .where((exercise) => exercise.id != event.exerciseId)
                .toList(),
            notes: session.notes,
          );
        }).toList();

        final updatedPlan = WorkoutPlan(
          id: currentPlan.id,
          memberId: currentPlan.memberId,
          name: currentPlan.name,
          type: currentPlan.type,
          durationWeeks: currentPlan.durationWeeks,
          sessionsPerWeek: currentPlan.sessionsPerWeek,
          sessions: updatedSessions,
          goals: currentPlan.goals,
          progress: currentPlan.progress,
        );

        emit(WorkoutPlanLoading());
        final savedPlan = await repository.updateWorkoutPlan(updatedPlan);
        emit(WorkoutPlanLoaded(savedPlan));
      } catch (error) {
        emit(WorkoutPlanError(error.toString()));
      }
    }
  }
}
