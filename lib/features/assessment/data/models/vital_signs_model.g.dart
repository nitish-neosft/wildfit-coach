// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vital_signs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VitalSignsModel _$VitalSignsModelFromJson(Map<String, dynamic> json) =>
    VitalSignsModel(
      bloodPressure: json['bloodPressure'] as String,
      restingHeartRate: (json['restingHeartRate'] as num).toInt(),
      bpCategory: json['bpCategory'] as String,
    );

Map<String, dynamic> _$VitalSignsModelToJson(VitalSignsModel instance) =>
    <String, dynamic>{
      'bloodPressure': instance.bloodPressure,
      'restingHeartRate': instance.restingHeartRate,
      'bpCategory': instance.bpCategory,
    };
