import 'package:equatable/equatable.dart';

class DashboardMember extends Equatable {
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

  const DashboardMember({
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

  @override
  List<Object?> get props => [
        id,
        name,
        avatar,
        plan,
        progress,
        nextSession,
        streakDays,
        lastActivity,
        activityTime,
        email,
        joinedAt,
        height,
        weight,
        bodyFat,
        muscleMass,
        bmi,
        lastAssessment,
        trainerName,
        membershipExpiry,
        lastCheckin,
        daysPresent,
        weeklyWorkoutGoal,
        measurements,
      ];
}
