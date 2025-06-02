import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/dashboard_member.dart';

part 'dashboard_member_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DashboardMemberModel {
  final String id;
  final String name;
  final String avatar;
  final String plan;
  final int progress;
  final String nextSession;
  final int streakDays;
  final String lastActivity;
  final String activityTime;
  final String email;
  final DateTime joinedAt;
  final double height;
  final double weight;
  final double bodyFat;
  final double muscleMass;
  final double bmi;
  final DateTime lastAssessment;
  final String trainerName;
  final DateTime membershipExpiry;
  final DateTime lastCheckin;
  final int daysPresent;
  final int weeklyWorkoutGoal;
  final Map<String, double> measurements;

  DashboardMemberModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.plan,
    required this.progress,
    required this.nextSession,
    required this.streakDays,
    required this.lastActivity,
    required this.activityTime,
    required this.email,
    required this.joinedAt,
    required this.height,
    required this.weight,
    required this.bodyFat,
    required this.muscleMass,
    required this.bmi,
    required this.lastAssessment,
    required this.trainerName,
    required this.membershipExpiry,
    required this.lastCheckin,
    required this.daysPresent,
    required this.weeklyWorkoutGoal,
    required this.measurements,
  });

  factory DashboardMemberModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardMemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardMemberModelToJson(this);

  DashboardMember toEntity() => DashboardMember(
        id: id,
        name: name,
        avatar: avatar,
        plan: plan,
        progress: progress,
        nextSession: nextSession,
        streakDays: streakDays,
        lastActivity: lastActivity,
        activityTime: activityTime,
        email: email,
        joinedAt: joinedAt,
        height: height,
        weight: weight,
        bodyFat: bodyFat,
        muscleMass: muscleMass,
        bmi: bmi,
        lastAssessment: lastAssessment,
        trainerName: trainerName,
        membershipExpiry: membershipExpiry,
        lastCheckin: lastCheckin,
        daysPresent: daysPresent,
        weeklyWorkoutGoal: weeklyWorkoutGoal,
        measurements: measurements,
      );
}
