// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flexibility_tests_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlexibilityTestsModel _$FlexibilityTestsModelFromJson(
        Map<String, dynamic> json) =>
    FlexibilityTestsModel(
      quadriceps: json['quadriceps'] as bool,
      hamstring: json['hamstring'] as bool,
      hipFlexors: json['hipFlexors'] as bool,
      shoulderMobility: json['shoulderMobility'] as bool,
      sitAndReach: json['sitAndReach'] as bool,
    );

Map<String, dynamic> _$FlexibilityTestsModelToJson(
        FlexibilityTestsModel instance) =>
    <String, dynamic>{
      'quadriceps': instance.quadriceps,
      'hamstring': instance.hamstring,
      'hipFlexors': instance.hipFlexors,
      'shoulderMobility': instance.shoulderMobility,
      'sitAndReach': instance.sitAndReach,
    };
