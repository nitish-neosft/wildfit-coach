// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      name: json['name'] as String,
      type: ActivityModel._activityTypeFromJson(json['type'] as String),
      time: DateTime.parse(json['time'] as String),
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'time': instance.time.toIso8601String(),
      'data': instance.data,
      'type': ActivityModel._activityTypeToJson(instance.type),
    };
