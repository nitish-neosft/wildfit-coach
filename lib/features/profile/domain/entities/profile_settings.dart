import 'package:equatable/equatable.dart';

class ProfileSettings extends Equatable {
  final String userId;
  final String name;
  final String email;
  final String avatar;
  final NotificationSettings notifications;
  final String language;
  final bool hasWorkoutPlan;
  final bool hasNutritionPlan;
  final bool hasFitnessTest;
  final bool hasUnpaidDues;

  const ProfileSettings({
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

  @override
  List<Object?> get props => [
        userId,
        name,
        email,
        avatar,
        notifications,
        language,
        hasWorkoutPlan,
        hasNutritionPlan,
        hasFitnessTest,
        hasUnpaidDues,
      ];
}

class NotificationSettings extends Equatable {
  final bool checkInReminders;
  final bool checkOutReminders;
  final bool nutritionPlanAlerts;
  final bool fitnessTestReminders;
  final bool workoutPlanAlerts;
  final bool trainerAttendanceSummary;
  final bool paymentReminders;

  const NotificationSettings({
    required this.checkInReminders,
    required this.checkOutReminders,
    required this.nutritionPlanAlerts,
    required this.fitnessTestReminders,
    required this.workoutPlanAlerts,
    required this.trainerAttendanceSummary,
    required this.paymentReminders,
  });

  @override
  List<Object?> get props => [
        checkInReminders,
        checkOutReminders,
        nutritionPlanAlerts,
        fitnessTestReminders,
        workoutPlanAlerts,
        trainerAttendanceSummary,
        paymentReminders,
      ];
}
