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
  final bool hasAssessment;
  final Map<String, dynamic>? measurements;
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
  final int? activeNutritionPlans;
  final int? progress;
  final String? nextSession;
  final String? lastActivity;
  final String? activityTime;
  final DateTime? lastAssessmentDate;

  const Member({
    required this.id,
    required this.name,
    this.phone,
    required this.email,
    this.avatar,
    required this.joinedAt,
    required this.plan,
    this.hasAssessment = false,
    this.measurements,
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
    this.activeNutritionPlans,
    this.progress,
    this.nextSession,
    this.lastActivity,
    this.activityTime,
    this.lastAssessmentDate,
  });

  bool get hasBloodPressureAssessment =>
      assessments?.any(
        (a) => a.type == AssessmentType.bloodPressure,
      ) ??
      false;

  bool get hasCardioFitnessAssessment =>
      assessments?.any(
        (a) => a.type == AssessmentType.cardioFitness,
      ) ??
      false;

  bool get hasMuscularFlexibilityAssessment =>
      assessments?.any(
        (a) => a.type == AssessmentType.muscularFlexibility,
      ) ??
      false;

  bool get hasDetailedMeasurementsAssessment =>
      assessments?.any(
        (a) => a.type == AssessmentType.detailedMeasurements,
      ) ??
      false;

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        email,
        avatar,
        joinedAt,
        plan,
        hasAssessment,
        measurements,
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
        activeNutritionPlans,
        progress,
        nextSession,
        lastActivity,
        activityTime,
        lastAssessmentDate,
      ];

  Member copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? avatar,
    DateTime? joinedAt,
    String? plan,
    bool? hasAssessment,
    Map<String, dynamic>? measurements,
    List<Assessment>? assessments,
    String? trainerName,
    DateTime? membershipExpiryDate,
    DateTime? lastCheckIn,
    int? daysPresent,
    List<Activity>? todayActivities,
    double? height,
    double? weight,
    double? bodyFat,
    double? muscleMass,
    double? bmi,
    double? weightGoal,
    double? bodyFatGoal,
    int? weeklyWorkoutGoal,
    List<DateTime>? checkIns,
    int? currentStreak,
    int? activePrograms,
    int? activeNutritionPlans,
    int? progress,
    String? nextSession,
    String? lastActivity,
    String? activityTime,
    DateTime? lastAssessmentDate,
  }) {
    return Member(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      joinedAt: joinedAt ?? this.joinedAt,
      plan: plan ?? this.plan,
      hasAssessment: hasAssessment ?? this.hasAssessment,
      measurements: measurements ?? this.measurements,
      assessments: assessments ?? this.assessments,
      trainerName: trainerName ?? this.trainerName,
      membershipExpiryDate: membershipExpiryDate ?? this.membershipExpiryDate,
      lastCheckIn: lastCheckIn ?? this.lastCheckIn,
      daysPresent: daysPresent ?? this.daysPresent,
      todayActivities: todayActivities ?? this.todayActivities,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bodyFat: bodyFat ?? this.bodyFat,
      muscleMass: muscleMass ?? this.muscleMass,
      bmi: bmi ?? this.bmi,
      weightGoal: weightGoal ?? this.weightGoal,
      bodyFatGoal: bodyFatGoal ?? this.bodyFatGoal,
      weeklyWorkoutGoal: weeklyWorkoutGoal ?? this.weeklyWorkoutGoal,
      checkIns: checkIns ?? this.checkIns,
      currentStreak: currentStreak ?? this.currentStreak,
      activePrograms: activePrograms ?? this.activePrograms,
      activeNutritionPlans: activeNutritionPlans ?? this.activeNutritionPlans,
      progress: progress ?? this.progress,
      nextSession: nextSession ?? this.nextSession,
      lastActivity: lastActivity ?? this.lastActivity,
      activityTime: activityTime ?? this.activityTime,
      lastAssessmentDate: lastAssessmentDate ?? this.lastAssessmentDate,
    );
  }
}
