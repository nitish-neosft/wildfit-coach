// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplementModel _$SupplementModelFromJson(Map<String, dynamic> json) =>
    SupplementModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      dosage: json['dosage'] as String,
      frequency: json['frequency'] as String,
      instructions: json['instructions'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SupplementModelToJson(SupplementModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'dosage': instance.dosage,
      'frequency': instance.frequency,
      'instructions': instance.instructions,
    };
