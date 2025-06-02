// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cardio_fitness_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardioFitnessModel _$CardioFitnessModelFromJson(Map<String, dynamic> json) =>
    CardioFitnessModel(
      vo2Max: (json['vo2Max'] as num).toDouble(),
      rockportTestResult: json['rockportTestResult'] as String,
      ymcaStepTestResult: json['ymcaStepTestResult'] as String,
      ymcaHeartRate: (json['ymcaHeartRate'] as num).toInt(),
    );

Map<String, dynamic> _$CardioFitnessModelToJson(CardioFitnessModel instance) =>
    <String, dynamic>{
      'vo2Max': instance.vo2Max,
      'rockportTestResult': instance.rockportTestResult,
      'ymcaStepTestResult': instance.ymcaStepTestResult,
      'ymcaHeartRate': instance.ymcaHeartRate,
    };
