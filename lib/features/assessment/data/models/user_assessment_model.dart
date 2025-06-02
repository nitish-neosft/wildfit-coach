import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_assessment.dart';
import 'vital_signs_model.dart';
import 'body_measurements_model.dart';
import 'cardio_fitness_model.dart';
import 'muscular_endurance_model.dart';
import 'flexibility_tests_model.dart';

part 'user_assessment_model.g.dart';

@JsonSerializable()
class UserAssessmentModel {
  final String id;
  final String name;
  final VitalSignsModel vitalSigns;
  final BodyMeasurementsModel bodyMeasurements;
  final CardioFitnessModel cardioFitness;
  final MuscularEnduranceModel muscularEndurance;
  final FlexibilityTestsModel flexibilityTests;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserAssessmentModel({
    required this.id,
    required this.name,
    required this.vitalSigns,
    required this.bodyMeasurements,
    required this.cardioFitness,
    required this.muscularEndurance,
    required this.flexibilityTests,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserAssessmentModel.fromJson(Map<String, dynamic> json) =>
      _$UserAssessmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserAssessmentModelToJson(this);

  factory UserAssessmentModel.fromEntity(UserAssessment entity) {
    return UserAssessmentModel(
      id: entity.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: entity.name,
      vitalSigns: VitalSignsModel.fromEntity(entity.vitalSigns),
      bodyMeasurements:
          BodyMeasurementsModel.fromEntity(entity.bodyMeasurements),
      cardioFitness: CardioFitnessModel.fromEntity(entity.cardioFitness),
      muscularEndurance:
          MuscularEnduranceModel.fromEntity(entity.muscularEndurance),
      flexibilityTests:
          FlexibilityTestsModel.fromEntity(entity.flexibilityTests),
      createdAt: entity.createdAt ?? DateTime.now(),
      updatedAt: entity.updatedAt ?? DateTime.now(),
    );
  }

  UserAssessment toEntity() {
    return UserAssessment(
      id: id,
      name: name,
      vitalSigns: vitalSigns.toEntity(),
      bodyMeasurements: bodyMeasurements.toEntity(),
      cardioFitness: cardioFitness.toEntity(),
      muscularEndurance: muscularEndurance.toEntity(),
      flexibilityTests: flexibilityTests.toEntity(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
