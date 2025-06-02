// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardStatsModel _$DashboardStatsModelFromJson(Map<String, dynamic> json) =>
    DashboardStatsModel(
      activeClients: (json['active_clients'] as num).toInt(),
      assessments: (json['assessments'] as num).toInt(),
      todaySessions: (json['today_sessions'] as num).toInt(),
      clientProgress: (json['client_progress'] as num).toInt(),
    );

Map<String, dynamic> _$DashboardStatsModelToJson(
        DashboardStatsModel instance) =>
    <String, dynamic>{
      'active_clients': instance.activeClients,
      'assessments': instance.assessments,
      'today_sessions': instance.todaySessions,
      'client_progress': instance.clientProgress,
    };

DashboardActivityModel _$DashboardActivityModelFromJson(
        Map<String, dynamic> json) =>
    DashboardActivityModel(
      id: json['id'] as String,
      memberId: json['member_id'] as String,
      memberName: json['member_name'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      time: json['time'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$DashboardActivityModelToJson(
        DashboardActivityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'member_id': instance.memberId,
      'member_name': instance.memberName,
      'type': instance.type,
      'title': instance.title,
      'description': instance.description,
      'time': instance.time,
      'icon': instance.icon,
    };

UpcomingSessionModel _$UpcomingSessionModelFromJson(
        Map<String, dynamic> json) =>
    UpcomingSessionModel(
      id: json['id'] as String,
      time: json['time'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      memberId: json['member_id'] as String?,
      type: json['type'] as String,
    );

Map<String, dynamic> _$UpcomingSessionModelToJson(
        UpcomingSessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'member_id': instance.memberId,
      'type': instance.type,
    };

DashboardDataModel _$DashboardDataModelFromJson(Map<String, dynamic> json) =>
    DashboardDataModel(
      stats:
          DashboardStatsModel.fromJson(json['stats'] as Map<String, dynamic>),
      members: (json['members'] as List<dynamic>)
          .map((e) => DashboardMemberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      activities: (json['activities'] as List<dynamic>)
          .map(
              (e) => DashboardActivityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      upcomingSessions: (json['upcoming_sessions'] as List<dynamic>)
          .map((e) => UpcomingSessionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardDataModelToJson(DashboardDataModel instance) =>
    <String, dynamic>{
      'stats': instance.stats,
      'members': instance.members,
      'activities': instance.activities,
      'upcoming_sessions': instance.upcomingSessions,
    };
