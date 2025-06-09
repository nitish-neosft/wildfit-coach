import 'package:equatable/equatable.dart';
import 'exercise.dart';

enum WorkoutPlanType { strength, hiit, flexibility, cardio, yoga, custom }

class WorkoutPlan extends Equatable {
  final String id;
  final String name;
  final String description;
  final String memberId;
  final String createdBy;
  final WorkoutPlanType type;
  final List<Exercise> exercises;
  final int sessionsPerWeek;
  final DateTime createdAt;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final double progress;
  final Map<String, dynamic> metadata;

  const WorkoutPlan({
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

  WorkoutPlan copyWith({
    String? id,
    String? name,
    String? description,
    String? memberId,
    String? createdBy,
    WorkoutPlanType? type,
    List<Exercise>? exercises,
    int? sessionsPerWeek,
    DateTime? createdAt,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    double? progress,
    Map<String, dynamic>? metadata,
  }) {
    return WorkoutPlan(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      memberId: memberId ?? this.memberId,
      createdBy: createdBy ?? this.createdBy,
      type: type ?? this.type,
      exercises: exercises ?? this.exercises,
      sessionsPerWeek: sessionsPerWeek ?? this.sessionsPerWeek,
      createdAt: createdAt ?? this.createdAt,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      progress: progress ?? this.progress,
      metadata: metadata ?? this.metadata,
    );
  }
}
