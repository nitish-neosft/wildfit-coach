import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/flexibility_tests.dart';

part 'flexibility_tests_model.g.dart';

@JsonSerializable()
class FlexibilityTestsModel extends FlexibilityTests {
  const FlexibilityTestsModel({
    required bool quadriceps,
    required bool hamstring,
    required bool hipFlexors,
    required bool shoulderMobility,
    required bool sitAndReach,
  }) : super(
          quadriceps: quadriceps,
          hamstring: hamstring,
          hipFlexors: hipFlexors,
          shoulderMobility: shoulderMobility,
          sitAndReach: sitAndReach,
        );

  factory FlexibilityTestsModel.empty() {
    return const FlexibilityTestsModel(
      quadriceps: false,
      hamstring: false,
      hipFlexors: false,
      shoulderMobility: false,
      sitAndReach: false,
    );
  }

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
