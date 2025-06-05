import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/member.dart';
import '../../domain/entities/activity.dart';
import '../../domain/entities/assessment.dart';
import 'activity_model.dart';
import 'assessment_model.dart';

part 'member_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MemberModel extends Member {
  @override
  final List<AssessmentModel>? assessments;

  @override
  final List<ActivityModel>? todayActivities;

  const MemberModel({
    required String id,
    required String name,
    String? phone,
    required String email,
    String? avatar,
    required DateTime joinedAt,
    required String plan,
    bool hasWorkoutPlan = false,
    bool hasNutritionPlan = false,
    bool hasAssessment = false,
    Map<String, dynamic>? measurements,
    List<String>? workoutPlanIds,
    List<String>? nutritionPlanIds,
    this.assessments,
    String? trainerName,
    required DateTime membershipExpiryDate,
    DateTime? lastCheckIn,
    int? daysPresent,
    this.todayActivities,
    required double height,
    required double weight,
    double? bodyFat,
    double? muscleMass,
    double? bmi,
    double? weightGoal,
    double? bodyFatGoal,
    int? weeklyWorkoutGoal,
    List<DateTime>? checkIns,
    int? currentStreak,
    int? activePrograms,
  }) : super(
          id: id,
          name: name,
          phone: phone,
          email: email,
          avatar: avatar,
          joinedAt: joinedAt,
          plan: plan,
          hasWorkoutPlan: hasWorkoutPlan,
          hasNutritionPlan: hasNutritionPlan,
          hasAssessment: hasAssessment,
          measurements: measurements,
          workoutPlanIds: workoutPlanIds,
          nutritionPlanIds: nutritionPlanIds,
          assessments: assessments,
          trainerName: trainerName,
          membershipExpiryDate: membershipExpiryDate,
          lastCheckIn: lastCheckIn,
          daysPresent: daysPresent,
          todayActivities: todayActivities,
          height: height,
          weight: weight,
          bodyFat: bodyFat,
          muscleMass: muscleMass,
          bmi: bmi,
          weightGoal: weightGoal,
          bodyFatGoal: bodyFatGoal,
          weeklyWorkoutGoal: weeklyWorkoutGoal,
          checkIns: checkIns,
          currentStreak: currentStreak,
          activePrograms: activePrograms,
        );

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  factory MemberModel.fromEntity(Member entity) {
    return MemberModel(
      id: entity.id,
      name: entity.name,
      phone: entity.phone,
      email: entity.email,
      avatar: entity.avatar,
      joinedAt: entity.joinedAt,
      plan: entity.plan,
      hasWorkoutPlan: entity.hasWorkoutPlan,
      hasNutritionPlan: entity.hasNutritionPlan,
      hasAssessment: entity.hasAssessment,
      measurements: entity.measurements,
      workoutPlanIds: entity.workoutPlanIds,
      nutritionPlanIds: entity.nutritionPlanIds,
      assessments: entity.assessments
          ?.map((assessment) => AssessmentModel(
                id: assessment.id,
                date: assessment.date,
                type: assessment.type,
                data: assessment.data,
              ))
          .toList(),
      trainerName: entity.trainerName,
      membershipExpiryDate: entity.membershipExpiryDate,
      lastCheckIn: entity.lastCheckIn,
      daysPresent: entity.daysPresent,
      todayActivities: entity.todayActivities
          ?.map((activity) => ActivityModel(
                name: activity.name,
                type: activity.type,
                time: activity.time,
                data: activity.data,
              ))
          .toList(),
      height: entity.height,
      weight: entity.weight,
      bodyFat: entity.bodyFat,
      muscleMass: entity.muscleMass,
      bmi: entity.bmi,
      weightGoal: entity.weightGoal,
      bodyFatGoal: entity.bodyFatGoal,
      weeklyWorkoutGoal: entity.weeklyWorkoutGoal,
      checkIns: entity.checkIns,
      currentStreak: entity.currentStreak,
      activePrograms: entity.activePrograms,
    );
  }

  Map<String, dynamic> toJson() => _$MemberModelToJson(this);
}

class AssessmentModel extends Assessment {
  const AssessmentModel({
    required String id,
    required DateTime date,
    required AssessmentType type,
    required Map<String, dynamic> data,
  }) : super(
          id: id,
          date: date,
          type: type,
          data: data,
        );

  factory AssessmentModel.fromJson(Map<String, dynamic> json) {
    return AssessmentModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      type: AssessmentType.values
          .firstWhere((e) => e.toString() == 'AssessmentType.${json['type']}'),
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

class ActivityModel extends Activity {
  const ActivityModel({
    required String name,
    required ActivityType type,
    required DateTime time,
    Map<String, dynamic>? data,
  }) : super(
          name: name,
          type: type,
          time: time,
          data: data,
        );

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      name: json['name'] as String,
      type: ActivityType.values
          .firstWhere((e) => e.toString() == 'ActivityType.${json['type']}'),
      time: DateTime.parse(json['time'] as String),
      data: json['data'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type.toString().split('.').last,
      'time': time.toIso8601String(),
      'data': data,
    };
  }
}
