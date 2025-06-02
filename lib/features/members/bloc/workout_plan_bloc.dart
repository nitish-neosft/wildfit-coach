import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/models/workout_plan.dart';

// Events
abstract class WorkoutPlanEvent {}

class LoadWorkoutPlan extends WorkoutPlanEvent {
  final String planId;
  final String memberId;

  LoadWorkoutPlan({
    required this.planId,
    required this.memberId,
  });
}

class UpdateWorkoutPlan extends WorkoutPlanEvent {
  final WorkoutPlan plan;

  UpdateWorkoutPlan(this.plan);
}

class AddExercise extends WorkoutPlanEvent {
  final Exercise exercise;

  AddExercise(this.exercise);
}

class UpdateExercise extends WorkoutPlanEvent {
  final Exercise exercise;

  UpdateExercise(this.exercise);
}

class DeleteExercise extends WorkoutPlanEvent {
  final String exerciseId;

  DeleteExercise(this.exerciseId);
}

// States
abstract class WorkoutPlanState {}

class WorkoutPlanInitial extends WorkoutPlanState {}

class WorkoutPlanLoading extends WorkoutPlanState {}

class WorkoutPlanLoaded extends WorkoutPlanState {
  final WorkoutPlan plan;

  WorkoutPlanLoaded(this.plan);
}

class WorkoutPlanError extends WorkoutPlanState {
  final String message;

  WorkoutPlanError(this.message);
}

// BLoC
class WorkoutPlanBloc extends Bloc<WorkoutPlanEvent, WorkoutPlanState> {
  WorkoutPlanBloc() : super(WorkoutPlanInitial()) {
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
    emit(WorkoutPlanLoading());
    try {
      // TODO: Implement API call to fetch workout plan
      // For now, return dummy data
      final plan = WorkoutPlan(
        id: event.planId,
        memberId: event.memberId,
        name: 'Full Body Strength Program',
        type: WorkoutType.strength,
        durationWeeks: 8,
        sessionsPerWeek: 3,
        difficulty: Difficulty.intermediate,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        lastUpdated: DateTime.now(),
        schedule: [
          WorkoutDay(
            dayNumber: 1,
            name: 'Push Day',
            description: 'Chest, Shoulders, and Triceps',
            exerciseIds: ['ex1', 'ex2', 'ex3', 'ex4', 'ex5'],
          ),
          WorkoutDay(
            dayNumber: 2,
            name: 'Pull Day',
            description: 'Back and Biceps',
            exerciseIds: ['ex6', 'ex7', 'ex8', 'ex9'],
          ),
          WorkoutDay(
            dayNumber: 3,
            name: 'Leg Day',
            description: 'Lower Body and Core',
            exerciseIds: ['ex10', 'ex11', 'ex12', 'ex13'],
          ),
        ],
        exercises: [
          Exercise(
            id: 'ex1',
            name: 'Bench Press',
            description: 'Barbell bench press for chest development',
            sets: 4,
            reps: 10,
            weight: 60.0,
          ),
          Exercise(
            id: 'ex2',
            name: 'Shoulder Press',
            description: 'Dumbbell overhead press',
            sets: 3,
            reps: 12,
            weight: 15.0,
          ),
          Exercise(
            id: 'ex3',
            name: 'Tricep Pushdown',
            description: 'Cable tricep pushdown',
            sets: 3,
            reps: 15,
            weight: 25.0,
          ),
          Exercise(
            id: 'ex4',
            name: 'Incline Dumbbell Press',
            description: 'Incline press for upper chest',
            sets: 3,
            reps: 12,
            weight: 22.5,
          ),
          Exercise(
            id: 'ex5',
            name: 'Lateral Raises',
            description: 'Dumbbell lateral raises for shoulders',
            sets: 3,
            reps: 15,
            weight: 8.0,
          ),
          Exercise(
            id: 'ex6',
            name: 'Pull-ups',
            description: 'Bodyweight pull-ups',
            sets: 4,
            reps: 8,
          ),
          Exercise(
            id: 'ex7',
            name: 'Barbell Rows',
            description: 'Bent over barbell rows',
            sets: 4,
            reps: 10,
            weight: 50.0,
          ),
          Exercise(
            id: 'ex8',
            name: 'Bicep Curls',
            description: 'Standing dumbbell bicep curls',
            sets: 3,
            reps: 12,
            weight: 12.5,
          ),
          Exercise(
            id: 'ex9',
            name: 'Face Pulls',
            description: 'Cable face pulls for rear delts',
            sets: 3,
            reps: 15,
            weight: 20.0,
          ),
          Exercise(
            id: 'ex10',
            name: 'Squats',
            description: 'Barbell back squats',
            sets: 4,
            reps: 8,
            weight: 80.0,
          ),
          Exercise(
            id: 'ex11',
            name: 'Romanian Deadlifts',
            description: 'RDLs for hamstrings',
            sets: 3,
            reps: 12,
            weight: 60.0,
          ),
          Exercise(
            id: 'ex12',
            name: 'Leg Press',
            description: 'Machine leg press',
            sets: 3,
            reps: 12,
            weight: 120.0,
          ),
          Exercise(
            id: 'ex13',
            name: 'Plank',
            description: 'Core stability exercise',
            sets: 3,
            reps: 1,
            duration: const Duration(seconds: 60),
          ),
        ],
      );
      emit(WorkoutPlanLoaded(plan));
    } catch (e) {
      emit(WorkoutPlanError(e.toString()));
    }
  }

  Future<void> _onUpdateWorkoutPlan(
    UpdateWorkoutPlan event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    try {
      // TODO: Implement API call to update workout plan
      emit(WorkoutPlanLoaded(event.plan));
    } catch (e) {
      emit(WorkoutPlanError(e.toString()));
    }
  }

  Future<void> _onAddExercise(
    AddExercise event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    try {
      // TODO: Implement API call to add exercise
      if (state is WorkoutPlanLoaded) {
        final currentPlan = (state as WorkoutPlanLoaded).plan;
        final updatedPlan = WorkoutPlan(
          id: currentPlan.id,
          memberId: currentPlan.memberId,
          name: currentPlan.name,
          type: currentPlan.type,
          durationWeeks: currentPlan.durationWeeks,
          sessionsPerWeek: currentPlan.sessionsPerWeek,
          difficulty: currentPlan.difficulty,
          createdAt: currentPlan.createdAt,
          lastUpdated: DateTime.now(),
          schedule: currentPlan.schedule,
          exercises: [...currentPlan.exercises, event.exercise],
        );
        emit(WorkoutPlanLoaded(updatedPlan));
      }
    } catch (e) {
      emit(WorkoutPlanError(e.toString()));
    }
  }

  Future<void> _onUpdateExercise(
    UpdateExercise event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    try {
      // TODO: Implement API call to update exercise
      if (state is WorkoutPlanLoaded) {
        final currentPlan = (state as WorkoutPlanLoaded).plan;
        final updatedExercises = currentPlan.exercises.map((e) {
          return e.id == event.exercise.id ? event.exercise : e;
        }).toList();
        final updatedPlan = WorkoutPlan(
          id: currentPlan.id,
          memberId: currentPlan.memberId,
          name: currentPlan.name,
          type: currentPlan.type,
          durationWeeks: currentPlan.durationWeeks,
          sessionsPerWeek: currentPlan.sessionsPerWeek,
          difficulty: currentPlan.difficulty,
          createdAt: currentPlan.createdAt,
          lastUpdated: DateTime.now(),
          schedule: currentPlan.schedule,
          exercises: updatedExercises,
        );
        emit(WorkoutPlanLoaded(updatedPlan));
      }
    } catch (e) {
      emit(WorkoutPlanError(e.toString()));
    }
  }

  Future<void> _onDeleteExercise(
    DeleteExercise event,
    Emitter<WorkoutPlanState> emit,
  ) async {
    try {
      // TODO: Implement API call to delete exercise
      if (state is WorkoutPlanLoaded) {
        final currentPlan = (state as WorkoutPlanLoaded).plan;
        final updatedExercises = currentPlan.exercises
            .where((e) => e.id != event.exerciseId)
            .toList();
        final updatedPlan = WorkoutPlan(
          id: currentPlan.id,
          memberId: currentPlan.memberId,
          name: currentPlan.name,
          type: currentPlan.type,
          durationWeeks: currentPlan.durationWeeks,
          sessionsPerWeek: currentPlan.sessionsPerWeek,
          difficulty: currentPlan.difficulty,
          createdAt: currentPlan.createdAt,
          lastUpdated: DateTime.now(),
          schedule: currentPlan.schedule,
          exercises: updatedExercises,
        );
        emit(WorkoutPlanLoaded(updatedPlan));
      }
    } catch (e) {
      emit(WorkoutPlanError(e.toString()));
    }
  }
}
