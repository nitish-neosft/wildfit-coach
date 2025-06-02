// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardMemberModel _$DashboardMemberModelFromJson(
        Map<String, dynamic> json) =>
    DashboardMemberModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      plan: json['plan'] as String,
      progress: (json['progress'] as num).toInt(),
      nextSession: json['next_session'] as String,
      streakDays: (json['streak_days'] as num).toInt(),
      lastActivity: json['last_activity'] as String,
      activityTime: json['activity_time'] as String,
      email: json['email'] as String,
      joinedAt: DateTime.parse(json['joined_at'] as String),
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      bodyFat: (json['body_fat'] as num).toDouble(),
      muscleMass: (json['muscle_mass'] as num).toDouble(),
      bmi: (json['bmi'] as num).toDouble(),
      lastAssessment: DateTime.parse(json['last_assessment'] as String),
      trainerName: json['trainer_name'] as String,
      membershipExpiry: DateTime.parse(json['membership_expiry'] as String),
      lastCheckin: DateTime.parse(json['last_checkin'] as String),
      daysPresent: (json['days_present'] as num).toInt(),
      weeklyWorkoutGoal: (json['weekly_workout_goal'] as num).toInt(),
      measurements: (json['measurements'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$DashboardMemberModelToJson(
        DashboardMemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'plan': instance.plan,
      'progress': instance.progress,
      'next_session': instance.nextSession,
      'streak_days': instance.streakDays,
      'last_activity': instance.lastActivity,
      'activity_time': instance.activityTime,
      'email': instance.email,
      'joined_at': instance.joinedAt.toIso8601String(),
      'height': instance.height,
      'weight': instance.weight,
      'body_fat': instance.bodyFat,
      'muscle_mass': instance.muscleMass,
      'bmi': instance.bmi,
      'last_assessment': instance.lastAssessment.toIso8601String(),
      'trainer_name': instance.trainerName,
      'membership_expiry': instance.membershipExpiry.toIso8601String(),
      'last_checkin': instance.lastCheckin.toIso8601String(),
      'days_present': instance.daysPresent,
      'weekly_workout_goal': instance.weeklyWorkoutGoal,
      'measurements': instance.measurements,
    };
