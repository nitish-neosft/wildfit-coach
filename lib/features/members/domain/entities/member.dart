import 'package:equatable/equatable.dart';
import 'activity.dart';
import 'assessment.dart';

class Member extends Equatable {
  final String id;
  final String name;
  final String? phone;
  final String email;
  final String? avatar;
  final DateTime joinedAt;
  final String plan;
  final bool hasWorkoutPlan;
  final bool hasNutritionPlan;
  final bool hasAssessment;
  final Map<String, dynamic>? measurements;
  final List<String>? workoutPlanIds;
  final List<String>? nutritionPlanIds;
  final List<Assessment>? assessments;
  final String? trainerName;
  final DateTime membershipExpiryDate;
  final DateTime? lastCheckIn;
  final int? daysPresent;
  final List<Activity>? todayActivities;
  final double height;
  final double weight;
  final double? bodyFat;
  final double? muscleMass;
  final double? bmi;
  final double? weightGoal;
  final double? bodyFatGoal;
  final int? weeklyWorkoutGoal;
  final List<DateTime>? checkIns;
  final int? currentStreak;
  final int? activePrograms;

  const Member({
    required this.id,
    required this.name,
    this.phone,
    required this.email,
    this.avatar,
    required this.joinedAt,
    required this.plan,
    this.hasWorkoutPlan = false,
    this.hasNutritionPlan = false,
    this.hasAssessment = false,
    this.measurements,
    this.workoutPlanIds,
    this.nutritionPlanIds,
    this.assessments,
    this.trainerName,
    required this.membershipExpiryDate,
    this.lastCheckIn,
    this.daysPresent,
    this.todayActivities,
    required this.height,
    required this.weight,
    this.bodyFat,
    this.muscleMass,
    this.bmi,
    this.weightGoal,
    this.bodyFatGoal,
    this.weeklyWorkoutGoal,
    this.checkIns,
    this.currentStreak,
    this.activePrograms,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        email,
        avatar,
        joinedAt,
        plan,
        hasWorkoutPlan,
        hasNutritionPlan,
        hasAssessment,
        measurements,
        workoutPlanIds,
        nutritionPlanIds,
        assessments,
        trainerName,
        membershipExpiryDate,
        lastCheckIn,
        daysPresent,
        todayActivities,
        height,
        weight,
        bodyFat,
        muscleMass,
        bmi,
        weightGoal,
        bodyFatGoal,
        weeklyWorkoutGoal,
        checkIns,
        currentStreak,
        activePrograms,
      ];
}
