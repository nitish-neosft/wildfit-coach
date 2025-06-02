import 'activity.dart';
import 'package:equatable/equatable.dart';
import '../../../dashboard/domain/entities/dashboard_member.dart';

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

  // Member details
  final String? trainerName;
  final DateTime membershipExpiryDate;
  final DateTime? lastCheckIn;
  final int? daysPresent;
  final List<Activity>? todayActivities;
  final double height;
  final double weight;

  // Health metrics
  final double? bodyFat;
  final double? muscleMass;
  final double? bmi;

  // Goals
  final double? weightGoal;
  final double? bodyFatGoal;
  final int? weeklyWorkoutGoal;

  // Progress tracking
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

  factory Member.fromDashboardMember(DashboardMember dashboardMember) {
    return Member(
      id: dashboardMember.id,
      name: dashboardMember.name,
      email: dashboardMember.email,
      avatar: dashboardMember.avatar,
      joinedAt: dashboardMember.joinedAt,
      plan: dashboardMember.plan,
      hasWorkoutPlan: false,
      hasNutritionPlan: false,
      hasAssessment: false,
      measurements: null,
      workoutPlanIds: null,
      nutritionPlanIds: null,
      assessments: null,
      trainerName: dashboardMember.trainerName,
      membershipExpiryDate: dashboardMember.membershipExpiry,
      lastCheckIn: dashboardMember.lastCheckin,
      daysPresent: dashboardMember.daysPresent,
      todayActivities: null,
      height: 0.0,
      weight: 0.0,
      bodyFat: null,
      muscleMass: null,
      bmi: null,
      weightGoal: null,
      bodyFatGoal: null,
      weeklyWorkoutGoal: null,
      checkIns: null,
      currentStreak: null,
      activePrograms: null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
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

  Member copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? avatar,
    DateTime? joinedAt,
    String? plan,
    bool? hasWorkoutPlan,
    bool? hasNutritionPlan,
    bool? hasAssessment,
    Map<String, dynamic>? measurements,
    List<String>? workoutPlanIds,
    List<String>? nutritionPlanIds,
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
  }) {
    return Member(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      joinedAt: joinedAt ?? this.joinedAt,
      plan: plan ?? this.plan,
      hasWorkoutPlan: hasWorkoutPlan ?? this.hasWorkoutPlan,
      hasNutritionPlan: hasNutritionPlan ?? this.hasNutritionPlan,
      hasAssessment: hasAssessment ?? this.hasAssessment,
      measurements: measurements ?? this.measurements,
      workoutPlanIds: workoutPlanIds ?? this.workoutPlanIds,
      nutritionPlanIds: nutritionPlanIds ?? this.nutritionPlanIds,
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
    );
  }
}

class Assessment {
  final String id;
  final DateTime date;
  final AssessmentType type;
  final Map<String, dynamic> data;

  const Assessment({
    required this.id,
    required this.date,
    required this.type,
    required this.data,
  });

  factory Assessment.fromJson(Map<String, dynamic> json) {
    return Assessment(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      type: AssessmentType.values.firstWhere(
        (e) => e.toString() == 'AssessmentType.${json['type']}',
      ),
      data: json['data'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'type': type.toString().split('.').last,
      'data': data,
    };
  }
}

enum AssessmentType {
  bloodPressure,
  cardioFitness,
  muscularFlexibility,
  detailedMeasurements,
}
