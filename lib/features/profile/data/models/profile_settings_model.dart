import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/profile_settings.dart';

part 'profile_settings_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileSettingsModel {
  final String userId;
  final String name;
  final String email;
  final String avatar;
  final NotificationSettingsModel notifications;
  final String language;
  final bool hasWorkoutPlan;
  final bool hasNutritionPlan;
  final bool hasFitnessTest;
  final bool hasUnpaidDues;

  const ProfileSettingsModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.avatar,
    required this.notifications,
    required this.language,
    required this.hasWorkoutPlan,
    required this.hasNutritionPlan,
    required this.hasFitnessTest,
    required this.hasUnpaidDues,
  });

  factory ProfileSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileSettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileSettingsModelToJson(this);

  ProfileSettings toEntity() => ProfileSettings(
        userId: userId,
        name: name,
        email: email,
        avatar: avatar,
        notifications: notifications.toEntity(),
        language: language,
        hasWorkoutPlan: hasWorkoutPlan,
        hasNutritionPlan: hasNutritionPlan,
        hasFitnessTest: hasFitnessTest,
        hasUnpaidDues: hasUnpaidDues,
      );
}

@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationSettingsModel {
  final bool checkInReminders;
  final bool checkOutReminders;
  final bool nutritionPlanAlerts;
  final bool fitnessTestReminders;
  final bool workoutPlanAlerts;
  final bool trainerAttendanceSummary;
  final bool paymentReminders;

  const NotificationSettingsModel({
    required this.checkInReminders,
    required this.checkOutReminders,
    required this.nutritionPlanAlerts,
    required this.fitnessTestReminders,
    required this.workoutPlanAlerts,
    required this.trainerAttendanceSummary,
    required this.paymentReminders,
  });

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationSettingsModelToJson(this);

  NotificationSettings toEntity() => NotificationSettings(
        checkInReminders: checkInReminders,
        checkOutReminders: checkOutReminders,
        nutritionPlanAlerts: nutritionPlanAlerts,
        fitnessTestReminders: fitnessTestReminders,
        workoutPlanAlerts: workoutPlanAlerts,
        trainerAttendanceSummary: trainerAttendanceSummary,
        paymentReminders: paymentReminders,
      );
}
