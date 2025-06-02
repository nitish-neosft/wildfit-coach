import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/dashboard_data.dart';
import 'dashboard_member_model.dart';

part 'dashboard_data_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DashboardStatsModel {
  final int activeClients;
  final int assessments;
  final int todaySessions;
  final int clientProgress;

  DashboardStatsModel({
    required this.activeClients,
    required this.assessments,
    required this.todaySessions,
    required this.clientProgress,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardStatsModelToJson(this);

  DashboardStats toEntity() => DashboardStats(
        activeClients: activeClients,
        assessments: assessments,
        todaySessions: todaySessions,
        clientProgress: clientProgress,
      );
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DashboardActivityModel {
  final String id;
  final String memberId;
  final String memberName;
  final String type;
  final String title;
  final String description;
  final String time;
  final String icon;

  DashboardActivityModel({
    required this.id,
    required this.memberId,
    required this.memberName,
    required this.type,
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
  });

  factory DashboardActivityModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardActivityModelToJson(this);

  DashboardActivity toEntity() => DashboardActivity(
        id: id,
        memberId: memberId,
        memberName: memberName,
        type: type,
        title: title,
        description: description,
        time: time,
        icon: icon,
      );
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UpcomingSessionModel {
  final String id;
  final String time;
  final String title;
  final String subtitle;
  final String? memberId;
  final String type;

  UpcomingSessionModel({
    required this.id,
    required this.time,
    required this.title,
    required this.subtitle,
    this.memberId,
    required this.type,
  });

  factory UpcomingSessionModel.fromJson(Map<String, dynamic> json) =>
      _$UpcomingSessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpcomingSessionModelToJson(this);

  UpcomingSession toEntity() => UpcomingSession(
        id: id,
        time: time,
        title: title,
        subtitle: subtitle,
        memberId: memberId,
        type: type,
      );
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DashboardDataModel {
  final DashboardStatsModel stats;
  final List<DashboardMemberModel> members;
  final List<DashboardActivityModel> activities;
  final List<UpcomingSessionModel> upcomingSessions;

  DashboardDataModel({
    required this.stats,
    required this.members,
    required this.activities,
    required this.upcomingSessions,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataModelToJson(this);

  DashboardData toEntity() => DashboardData(
        stats: stats.toEntity(),
        members: members.map((m) => m.toEntity()).toList(),
        activities: activities.map((a) => a.toEntity()).toList(),
        upcomingSessions: upcomingSessions.map((s) => s.toEntity()).toList(),
      );
}
