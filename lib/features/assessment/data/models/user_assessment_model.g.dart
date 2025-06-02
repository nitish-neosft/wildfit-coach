// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_assessment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAssessmentModel _$UserAssessmentModelFromJson(Map<String, dynamic> json) =>
    UserAssessmentModel(
      id: json['id'] as String,
      name: json['name'] as String,
      vitalSigns:
          VitalSignsModel.fromJson(json['vitalSigns'] as Map<String, dynamic>),
      bodyMeasurements: BodyMeasurementsModel.fromJson(
          json['bodyMeasurements'] as Map<String, dynamic>),
      cardioFitness: CardioFitnessModel.fromJson(
          json['cardioFitness'] as Map<String, dynamic>),
      muscularEndurance: MuscularEnduranceModel.fromJson(
          json['muscularEndurance'] as Map<String, dynamic>),
      flexibilityTests: FlexibilityTestsModel.fromJson(
          json['flexibilityTests'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserAssessmentModelToJson(
        UserAssessmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'vitalSigns': instance.vitalSigns,
      'bodyMeasurements': instance.bodyMeasurements,
      'cardioFitness': instance.cardioFitness,
      'muscularEndurance': instance.muscularEndurance,
      'flexibilityTests': instance.flexibilityTests,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
