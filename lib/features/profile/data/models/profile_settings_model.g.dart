// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileSettingsModel _$ProfileSettingsModelFromJson(
        Map<String, dynamic> json) =>
    ProfileSettingsModel(
      userId: json['user_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String,
      notifications: NotificationSettingsModel.fromJson(
          json['notifications'] as Map<String, dynamic>),
      language: json['language'] as String,
      hasWorkoutPlan: json['has_workout_plan'] as bool,
      hasNutritionPlan: json['has_nutrition_plan'] as bool,
      hasFitnessTest: json['has_fitness_test'] as bool,
      hasUnpaidDues: json['has_unpaid_dues'] as bool,
    );

Map<String, dynamic> _$ProfileSettingsModelToJson(
        ProfileSettingsModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
      'notifications': instance.notifications,
      'language': instance.language,
      'has_workout_plan': instance.hasWorkoutPlan,
      'has_nutrition_plan': instance.hasNutritionPlan,
      'has_fitness_test': instance.hasFitnessTest,
      'has_unpaid_dues': instance.hasUnpaidDues,
    };

NotificationSettingsModel _$NotificationSettingsModelFromJson(
        Map<String, dynamic> json) =>
    NotificationSettingsModel(
      checkInReminders: json['check_in_reminders'] as bool,
      checkOutReminders: json['check_out_reminders'] as bool,
      nutritionPlanAlerts: json['nutrition_plan_alerts'] as bool,
      fitnessTestReminders: json['fitness_test_reminders'] as bool,
      workoutPlanAlerts: json['workout_plan_alerts'] as bool,
      trainerAttendanceSummary: json['trainer_attendance_summary'] as bool,
      paymentReminders: json['payment_reminders'] as bool,
    );

Map<String, dynamic> _$NotificationSettingsModelToJson(
        NotificationSettingsModel instance) =>
    <String, dynamic>{
      'check_in_reminders': instance.checkInReminders,
      'check_out_reminders': instance.checkOutReminders,
      'nutrition_plan_alerts': instance.nutritionPlanAlerts,
      'fitness_test_reminders': instance.fitnessTestReminders,
      'workout_plan_alerts': instance.workoutPlanAlerts,
      'trainer_attendance_summary': instance.trainerAttendanceSummary,
      'payment_reminders': instance.paymentReminders,
    };
