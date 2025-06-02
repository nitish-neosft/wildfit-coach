class DashboardStats {
  final int activeClients;
  final int assessments;
  final int todaySessions;
  final int clientProgress;

  DashboardStats({
    required this.activeClients,
    required this.assessments,
    required this.todaySessions,
    required this.clientProgress,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      activeClients: json['active_clients'] as int,
      assessments: json['assessments'] as int,
      todaySessions: json['today_sessions'] as int,
      clientProgress: json['client_progress'] as int,
    );
  }
}

class DashboardMember {
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

  DashboardMember({
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

  factory DashboardMember.fromJson(Map<String, dynamic> json) {
    return DashboardMember(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      plan: json['plan'] as String,
      progress: json['progress'] as int,
      nextSession: json['next_session'] as String,
      streakDays: json['streak_days'] as int,
      lastActivity: json['last_activity'] as String,
      activityTime: json['activity_time'] as String,
      email: json['email'] as String,
      joinedAt: DateTime.parse(json['joined_at'] as String),
      height: json['height'] as double,
      weight: json['weight'] as double,
      bodyFat: json['body_fat'] as double,
      muscleMass: json['muscle_mass'] as double,
      bmi: json['bmi'] as double,
      lastAssessment: DateTime.parse(json['last_assessment'] as String),
      trainerName: json['trainer_name'] as String,
      membershipExpiry: DateTime.parse(json['membership_expiry'] as String),
      lastCheckin: DateTime.parse(json['last_checkin'] as String),
      daysPresent: json['days_present'] as int,
      weeklyWorkoutGoal: json['weekly_workout_goal'] as int,
      measurements: Map<String, double>.from(json['measurements'] as Map),
    );
  }
}

class DashboardActivity {
  final String id;
  final String memberId;
  final String memberName;
  final String type;
  final String title;
  final String description;
  final String time;
  final String icon;

  DashboardActivity({
    required this.id,
    required this.memberId,
    required this.memberName,
    required this.type,
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
  });

  factory DashboardActivity.fromJson(Map<String, dynamic> json) {
    return DashboardActivity(
      id: json['id'] as String,
      memberId: json['member_id'] as String,
      memberName: json['member_name'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      time: json['time'] as String,
      icon: json['icon'] as String,
    );
  }
}

class UpcomingSession {
  final String id;
  final String time;
  final String title;
  final String subtitle;
  final String? memberId;
  final String type;

  UpcomingSession({
    required this.id,
    required this.time,
    required this.title,
    required this.subtitle,
    this.memberId,
    required this.type,
  });

  factory UpcomingSession.fromJson(Map<String, dynamic> json) {
    return UpcomingSession(
      id: json['id'] as String,
      time: json['time'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      memberId: json['member_id'] as String?,
      type: json['type'] as String,
    );
  }
}

class DashboardData {
  final DashboardStats stats;
  final List<DashboardMember> members;
  final List<DashboardActivity> activities;
  final List<UpcomingSession> upcomingSessions;

  DashboardData({
    required this.stats,
    required this.members,
    required this.activities,
    required this.upcomingSessions,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      stats: DashboardStats.fromJson(json['stats'] as Map<String, dynamic>),
      members: (json['members'] as List<dynamic>)
          .map((e) => DashboardMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      activities: (json['activities'] as List<dynamic>)
          .map((e) => DashboardActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
      upcomingSessions: (json['upcoming_sessions'] as List<dynamic>)
          .map((e) => UpcomingSession.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
