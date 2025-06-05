// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutPlanModel _$WorkoutPlanModelFromJson(Map<String, dynamic> json) =>
    WorkoutPlanModel(
      id: json['id'] as String,
      memberId: json['member_id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      durationWeeks: (json['duration_weeks'] as num).toInt(),
      sessionsPerWeek: (json['sessions_per_week'] as num).toInt(),
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => WorkoutSessionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      goals: json['goals'] as Map<String, dynamic>?,
      progress: json['progress'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$WorkoutPlanModelToJson(WorkoutPlanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'member_id': instance.memberId,
      'name': instance.name,
      'type': instance.type,
      'duration_weeks': instance.durationWeeks,
      'sessions_per_week': instance.sessionsPerWeek,
      'goals': instance.goals,
      'progress': instance.progress,
      'sessions': instance.sessions.map((e) => e.toJson()).toList(),
    };
