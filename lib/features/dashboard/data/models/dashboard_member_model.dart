import 'package:json_annotation/json_annotation.dart';
import '../../../../features/members/domain/entities/member.dart';

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

  factory DashboardMemberModel.fromJson(Map<String, dynamic> json) {
    return DashboardMemberModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      plan: json['plan'] as String,
      progress: (json['progress'] as num?)?.toInt() ?? 0,
      nextSession: json['next_session'] as String,
      streakDays: (json['streak_days'] as num?)?.toInt() ?? 0,
      lastActivity: json['last_activity'] as String,
      activityTime: json['activity_time'] as String,
      email: json['email'] as String,
      joinedAt: DateTime.parse(json['joined_at'] as String),
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      bodyFat: (json['body_fat'] as num?)?.toDouble() ?? 0.0,
      muscleMass: (json['muscle_mass'] as num?)?.toDouble() ?? 0.0,
      bmi: (json['bmi'] as num?)?.toDouble() ?? 0.0,
      lastAssessment: DateTime.parse(json['last_assessment'] as String),
      trainerName: json['trainer_name'] as String,
      membershipExpiry: DateTime.parse(json['membership_expiry'] as String),
      lastCheckin: DateTime.parse(json['last_checkin'] as String),
      daysPresent: (json['days_present'] as num?)?.toInt() ?? 0,
      weeklyWorkoutGoal: (json['weekly_workout_goal'] as num?)?.toInt() ?? 0,
      measurements: Map<String, double>.from(
        (json['measurements'] as Map<String, dynamic>).map(
          (k, v) => MapEntry(k, (v as num).toDouble()),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatar': avatar,
        'plan': plan,
        'progress': progress,
        'next_session': nextSession,
        'streak_days': streakDays,
        'last_activity': lastActivity,
        'activity_time': activityTime,
        'email': email,
        'joined_at': joinedAt.toIso8601String(),
        'height': height,
        'weight': weight,
        'body_fat': bodyFat,
        'muscle_mass': muscleMass,
        'bmi': bmi,
        'last_assessment': lastAssessment.toIso8601String(),
        'trainer_name': trainerName,
        'membership_expiry': membershipExpiry.toIso8601String(),
        'last_checkin': lastCheckin.toIso8601String(),
        'days_present': daysPresent,
        'weekly_workout_goal': weeklyWorkoutGoal,
        'measurements': measurements,
      };

  Member toEntity() => Member(
        id: id,
        name: name,
        avatar: avatar,
        plan: plan,
        progress: progress,
        nextSession: nextSession,
        currentStreak: streakDays,
        lastActivity: lastActivity,
        activityTime: activityTime,
        email: email,
        joinedAt: joinedAt,
        height: height,
        weight: weight,
        bodyFat: bodyFat,
        muscleMass: muscleMass,
        bmi: bmi,
        trainerName: trainerName,
        membershipExpiryDate: membershipExpiry,
        lastCheckIn: lastCheckin,
        daysPresent: daysPresent,
        weeklyWorkoutGoal: weeklyWorkoutGoal,
        measurements: measurements,
      );
}
