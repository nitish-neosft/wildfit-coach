// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => MemberModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      email: json['email'] as String,
      avatar: json['avatar'] as String?,
      joinedAt: DateTime.parse(json['joined_at'] as String),
      plan: json['plan'] as String,
      hasWorkoutPlan: json['has_workout_plan'] as bool? ?? false,
      hasNutritionPlan: json['has_nutrition_plan'] as bool? ?? false,
      hasAssessment: json['has_assessment'] as bool? ?? false,
      measurements: json['measurements'] as Map<String, dynamic>?,
      workoutPlanIds: (json['workout_plan_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      nutritionPlanIds: (json['nutrition_plan_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      assessments: (json['assessments'] as List<dynamic>?)
          ?.map((e) => AssessmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      trainerName: json['trainer_name'] as String?,
      membershipExpiryDate:
          DateTime.parse(json['membership_expiry_date'] as String),
      lastCheckIn: json['last_check_in'] == null
          ? null
          : DateTime.parse(json['last_check_in'] as String),
      daysPresent: (json['days_present'] as num?)?.toInt(),
      todayActivities: (json['today_activities'] as List<dynamic>?)
          ?.map((e) => ActivityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      bodyFat: (json['body_fat'] as num?)?.toDouble(),
      muscleMass: (json['muscle_mass'] as num?)?.toDouble(),
      bmi: (json['bmi'] as num?)?.toDouble(),
      weightGoal: (json['weight_goal'] as num?)?.toDouble(),
      bodyFatGoal: (json['body_fat_goal'] as num?)?.toDouble(),
      weeklyWorkoutGoal: (json['weekly_workout_goal'] as num?)?.toInt(),
      checkIns: (json['check_ins'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      currentStreak: (json['current_streak'] as num?)?.toInt(),
      activePrograms: (json['active_programs'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MemberModelToJson(MemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'avatar': instance.avatar,
      'joined_at': instance.joinedAt.toIso8601String(),
      'plan': instance.plan,
      'has_workout_plan': instance.hasWorkoutPlan,
      'has_nutrition_plan': instance.hasNutritionPlan,
      'has_assessment': instance.hasAssessment,
      'measurements': instance.measurements,
      'workout_plan_ids': instance.workoutPlanIds,
      'nutrition_plan_ids': instance.nutritionPlanIds,
      'trainer_name': instance.trainerName,
      'membership_expiry_date': instance.membershipExpiryDate.toIso8601String(),
      'last_check_in': instance.lastCheckIn?.toIso8601String(),
      'days_present': instance.daysPresent,
      'height': instance.height,
      'weight': instance.weight,
      'body_fat': instance.bodyFat,
      'muscle_mass': instance.muscleMass,
      'bmi': instance.bmi,
      'weight_goal': instance.weightGoal,
      'body_fat_goal': instance.bodyFatGoal,
      'weekly_workout_goal': instance.weeklyWorkoutGoal,
      'check_ins': instance.checkIns?.map((e) => e.toIso8601String()).toList(),
      'current_streak': instance.currentStreak,
      'active_programs': instance.activePrograms,
      'assessments': instance.assessments?.map((e) => e.toJson()).toList(),
      'today_activities':
          instance.todayActivities?.map((e) => e.toJson()).toList(),
    };
