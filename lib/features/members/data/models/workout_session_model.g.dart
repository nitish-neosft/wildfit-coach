// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutSessionModel _$WorkoutSessionModelFromJson(Map<String, dynamic> json) =>
    WorkoutSessionModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      dayOfWeek: (json['day_of_week'] as num).toInt(),
      duration: WorkoutSessionModel._durationFromJson(
          (json['duration'] as num).toInt()),
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => ExerciseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$WorkoutSessionModelToJson(
        WorkoutSessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'day_of_week': instance.dayOfWeek,
      'notes': instance.notes,
      'exercises': instance.exercises.map((e) => e.toJson()).toList(),
      'duration': WorkoutSessionModel._durationToJson(instance.duration),
    };
