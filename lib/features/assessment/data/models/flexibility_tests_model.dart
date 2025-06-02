import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/flexibility_tests.dart';

part 'flexibility_tests_model.g.dart';

@JsonSerializable()
class FlexibilityTestsModel {
  final bool quadriceps;
  final bool hamstring;
  final bool hipFlexors;
  final bool shoulderMobility;
  final bool sitAndReach;

  FlexibilityTestsModel({
    required this.quadriceps,
    required this.hamstring,
    required this.hipFlexors,
    required this.shoulderMobility,
    required this.sitAndReach,
  });

  factory FlexibilityTestsModel.fromJson(Map<String, dynamic> json) =>
      _$FlexibilityTestsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FlexibilityTestsModelToJson(this);

  factory FlexibilityTestsModel.fromEntity(FlexibilityTests entity) {
    return FlexibilityTestsModel(
      quadriceps: entity.quadriceps,
      hamstring: entity.hamstring,
      hipFlexors: entity.hipFlexors,
      shoulderMobility: entity.shoulderMobility,
      sitAndReach: entity.sitAndReach,
    );
  }

  FlexibilityTests toEntity() {
    return FlexibilityTests(
      quadriceps: quadriceps,
      hamstring: hamstring,
      hipFlexors: hipFlexors,
      shoulderMobility: shoulderMobility,
      sitAndReach: sitAndReach,
    );
  }
}
