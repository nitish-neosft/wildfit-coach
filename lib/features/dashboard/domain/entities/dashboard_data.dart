import 'package:equatable/equatable.dart';
import 'package:wildfit_coach/features/members/domain/entities/member.dart';

class DashboardStats extends Equatable {
  final int activeClients;
  final int assessments;
  final int todaySessions;
  final int clientProgress;

  const DashboardStats({
    required this.activeClients,
    required this.assessments,
    required this.todaySessions,
    required this.clientProgress,
  });

  @override
  List<Object?> get props => [
        activeClients,
        assessments,
        todaySessions,
        clientProgress,
      ];
}

class DashboardActivity extends Equatable {
  final String id;
  final String memberId;
  final String memberName;
  final String type;
  final String title;
  final String description;
  final String time;
  final String icon;

  const DashboardActivity({
    required this.id,
    required this.memberId,
    required this.memberName,
    required this.type,
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
  });

  @override
  List<Object?> get props => [
        id,
        memberId,
        memberName,
        type,
        title,
        description,
        time,
        icon,
      ];
}

class UpcomingSession extends Equatable {
  final String id;
  final String time;
  final String title;
  final String subtitle;
  final String? memberId;
  final String type;

  const UpcomingSession({
    required this.id,
    required this.time,
    required this.title,
    required this.subtitle,
    this.memberId,
    required this.type,
  });

  @override
  List<Object?> get props => [
        id,
        time,
        title,
        subtitle,
        memberId,
        type,
      ];
}

class DashboardData extends Equatable {
  final DashboardStats stats;
  final List<Member> members;
  final List<DashboardActivity> activities;
  final List<UpcomingSession> upcomingSessions;

  const DashboardData({
    required this.stats,
    required this.members,
    required this.activities,
    required this.upcomingSessions,
  });

  @override
  List<Object?> get props => [
        stats,
        members,
        activities,
        upcomingSessions,
      ];
}
