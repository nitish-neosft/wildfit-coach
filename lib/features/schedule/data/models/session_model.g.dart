// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) => SessionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      notes: json['notes'] as String?,
      date: DateTime.parse(json['date'] as String),
      time: const TimeOfDayConverter().fromJson(json['time'] as String),
      memberId: json['member_id'] as String?,
      memberName: json['member_name'] as String?,
      memberAvatar: json['member_avatar'] as String?,
      type: json['type'] as String,
      isCompleted: json['is_completed'] as bool? ?? false,
    );

Map<String, dynamic> _$SessionModelToJson(SessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'notes': instance.notes,
      'date': instance.date.toIso8601String(),
      'member_id': instance.memberId,
      'member_name': instance.memberName,
      'member_avatar': instance.memberAvatar,
      'type': instance.type,
      'is_completed': instance.isCompleted,
      'time': const TimeOfDayConverter().toJson(instance.time),
    };
