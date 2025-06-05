// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseModel _$ExerciseModelFromJson(Map<String, dynamic> json) =>
    ExerciseModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      sets: (json['sets'] as num).toInt(),
      reps: (json['reps'] as num).toInt(),
      weight: (json['weight'] as num?)?.toDouble(),
      duration:
          ExerciseModel._durationFromJson((json['duration'] as num?)?.toInt()),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ExerciseModelToJson(ExerciseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'sets': instance.sets,
      'reps': instance.reps,
      'weight': instance.weight,
      'metadata': instance.metadata,
      'duration': ExerciseModel._durationToJson(instance.duration),
    };
