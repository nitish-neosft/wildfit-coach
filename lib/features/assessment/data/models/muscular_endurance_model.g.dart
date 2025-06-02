// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscular_endurance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MuscularEnduranceModel _$MuscularEnduranceModelFromJson(
        Map<String, dynamic> json) =>
    MuscularEnduranceModel(
      pushUps: (json['pushUps'] as num).toInt(),
      pushUpType: json['pushUpType'] as String,
      squats: (json['squats'] as num).toInt(),
      squatType: json['squatType'] as String,
      pullUps: (json['pullUps'] as num).toInt(),
    );

Map<String, dynamic> _$MuscularEnduranceModelToJson(
        MuscularEnduranceModel instance) =>
    <String, dynamic>{
      'pushUps': instance.pushUps,
      'pushUpType': instance.pushUpType,
      'squats': instance.squats,
      'squatType': instance.squatType,
      'pullUps': instance.pullUps,
    };
