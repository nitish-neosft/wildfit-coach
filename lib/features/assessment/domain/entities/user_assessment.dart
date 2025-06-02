import 'package:equatable/equatable.dart';
import 'vital_signs.dart';
import 'body_measurements.dart';
import 'cardio_fitness.dart';
import 'muscular_endurance.dart';
import 'flexibility_tests.dart';

class UserAssessment extends Equatable {
  final String? id;
  final String name;
  final VitalSigns vitalSigns;
  final BodyMeasurements bodyMeasurements;
  final CardioFitness cardioFitness;
  final MuscularEndurance muscularEndurance;
  final FlexibilityTests flexibilityTests;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserAssessment({
    this.id,
    required this.name,
    required this.vitalSigns,
    required this.bodyMeasurements,
    required this.cardioFitness,
    required this.muscularEndurance,
    required this.flexibilityTests,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        vitalSigns,
        bodyMeasurements,
        cardioFitness,
        muscularEndurance,
        flexibilityTests,
        createdAt,
        updatedAt,
      ];
}
