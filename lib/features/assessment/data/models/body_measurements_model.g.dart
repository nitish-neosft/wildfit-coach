// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_measurements_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BodyMeasurementsModel _$BodyMeasurementsModelFromJson(
        Map<String, dynamic> json) =>
    BodyMeasurementsModel(
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      chest: (json['chest'] as num).toDouble(),
      waist: (json['waist'] as num).toDouble(),
      hips: (json['hips'] as num).toDouble(),
      arms: (json['arms'] as num).toDouble(),
      neck: (json['neck'] as num).toDouble(),
      forearm: (json['forearm'] as num).toDouble(),
      calf: (json['calf'] as num).toDouble(),
      midThigh: (json['midThigh'] as num).toDouble(),
    );

Map<String, dynamic> _$BodyMeasurementsModelToJson(
        BodyMeasurementsModel instance) =>
    <String, dynamic>{
      'height': instance.height,
      'weight': instance.weight,
      'chest': instance.chest,
      'waist': instance.waist,
      'hips': instance.hips,
      'arms': instance.arms,
      'neck': instance.neck,
      'forearm': instance.forearm,
      'calf': instance.calf,
      'midThigh': instance.midThigh,
    };
