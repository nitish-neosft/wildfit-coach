import 'package:equatable/equatable.dart';
import '../../domain/entities/workout_plan.dart';
import 'exercise_model.dart';

class WorkoutPlanModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String memberId;
  final String createdBy;
  final WorkoutPlanType type;
  final List<ExerciseModel> exercises;
  final int sessionsPerWeek;
  final DateTime createdAt;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final double progress;
  final Map<String, dynamic> metadata;

  const WorkoutPlanModel({
    required this.id,
    required this.name,
    required this.description,
    required this.memberId,
    required this.createdBy,
    required this.type,
    required this.exercises,
    required this.sessionsPerWeek,
    required this.createdAt,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.progress,
    required this.metadata,
  });

  factory WorkoutPlanModel.fromJson(Map<String, dynamic> json) {
    return WorkoutPlanModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      memberId: json['member_id'] as String,
      createdBy: json['created_by'] as String,
      type: _parseWorkoutPlanType(json['type'] as String),
      exercises: (json['exercises'] as List)
          .map((e) => ExerciseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sessionsPerWeek: json['sessions_per_week'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      isActive: json['is_active'] as bool,
      progress: (json['progress'] as num).toDouble(),
      metadata: Map<String, dynamic>.from(json['metadata'] as Map),
    );
  }

  factory WorkoutPlanModel.fromEntity(WorkoutPlan entity) {
    return WorkoutPlanModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      memberId: entity.memberId,
      createdBy: entity.createdBy,
      type: entity.type,
      exercises: entity.exercises
          .map((exercise) => ExerciseModel.fromEntity(exercise))
          .toList(),
      sessionsPerWeek: entity.sessionsPerWeek,
      createdAt: entity.createdAt,
      startDate: entity.startDate,
      endDate: entity.endDate,
      isActive: entity.isActive,
      progress: entity.progress,
      metadata: Map<String, dynamic>.from(entity.metadata),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'member_id': memberId,
      'created_by': createdBy,
      'type': type.toString().split('.').last,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'sessions_per_week': sessionsPerWeek,
      'created_at': createdAt.toIso8601String(),
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'is_active': isActive,
      'progress': progress,
      'metadata': metadata,
    };
  }

  WorkoutPlan toEntity() {
    return WorkoutPlan(
      id: id,
      name: name,
      description: description,
      memberId: memberId,
      createdBy: createdBy,
      type: type,
      exercises: exercises.map((e) => e.toEntity()).toList(),
      sessionsPerWeek: sessionsPerWeek,
      createdAt: createdAt,
      startDate: startDate,
      endDate: endDate,
      isActive: isActive,
      progress: progress,
      metadata: Map<String, dynamic>.from(metadata),
    );
  }

  static WorkoutPlanType _parseWorkoutPlanType(String type) {
    switch (type) {
      case 'strength':
        return WorkoutPlanType.strength;
      case 'hiit':
        return WorkoutPlanType.hiit;
      case 'flexibility':
        return WorkoutPlanType.flexibility;
      case 'cardio':
        return WorkoutPlanType.cardio;
      case 'yoga':
        return WorkoutPlanType.yoga;
      default:
        return WorkoutPlanType.custom;
    }
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        memberId,
        createdBy,
        type,
        exercises,
        sessionsPerWeek,
        createdAt,
        startDate,
        endDate,
        isActive,
        progress,
        metadata,
      ];
}
