// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssessmentModel _$AssessmentModelFromJson(Map<String, dynamic> json) =>
    AssessmentModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      type: AssessmentModel._assessmentTypeFromJson(json['type'] as String),
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$AssessmentModelToJson(AssessmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'data': instance.data,
      'type': AssessmentModel._assessmentTypeToJson(instance.type),
    };
