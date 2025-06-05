import 'package:equatable/equatable.dart';

class Exercise extends Equatable {
  final String id;
  final String name;
  final String type;
  final int sets;
  final int reps;
  final double? weight;
  final Duration? duration;
  final Map<String, dynamic>? metadata;

  const Exercise({
    required this.id,
    required this.name,
    required this.type,
    required this.sets,
    required this.reps,
    this.weight,
    this.duration,
    this.metadata,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        sets,
        reps,
        weight,
        duration,
        metadata,
      ];
}

class WorkoutSession extends Equatable {
  final String id;
  final String name;
  final String type;
  final int dayOfWeek;
  final Duration duration;
  final List<Exercise> exercises;
  final String? notes;

  const WorkoutSession({
    required this.id,
    required this.name,
    required this.type,
    required this.dayOfWeek,
    required this.duration,
    required this.exercises,
    this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        dayOfWeek,
        duration,
        exercises,
        notes,
      ];
}

class WorkoutPlan extends Equatable {
  final String id;
  final String memberId;
  final String name;
  final String type;
  final int durationWeeks;
  final int sessionsPerWeek;
  final List<WorkoutSession> sessions;
  final Map<String, dynamic>? goals;
  final Map<String, dynamic>? progress;

  const WorkoutPlan({
    required this.id,
    required this.memberId,
    required this.name,
    required this.type,
    required this.durationWeeks,
    required this.sessionsPerWeek,
    required this.sessions,
    this.goals,
    this.progress,
  });

  @override
  List<Object?> get props => [
        id,
        memberId,
        name,
        type,
        durationWeeks,
        sessionsPerWeek,
        sessions,
        goals,
        progress,
      ];
}
