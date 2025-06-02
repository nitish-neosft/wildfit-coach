part of 'cardio_fitness_bloc.dart';

abstract class CardioFitnessEvent extends Equatable {
  const CardioFitnessEvent();

  @override
  List<Object?> get props => [];
}

class UpdateRockportCategory extends CardioFitnessEvent {
  final String category;

  const UpdateRockportCategory(this.category);

  @override
  List<Object> get props => [category];
}

class UpdateYmcaCategory extends CardioFitnessEvent {
  final String category;

  const UpdateYmcaCategory(this.category);

  @override
  List<Object> get props => [category];
}

class SaveCardioFitness extends CardioFitnessEvent {
  final double time;
  final double distance;
  final int pulse;
  final double vo2max;
  final String rockportFitnessCategory;
  final int ymcaHeartRate;
  final String ymcaFitnessCategory;
  final DateTime date;
  final VitalSigns vitalSigns;
  final BodyMeasurements bodyMeasurements;
  final MuscularEndurance muscularEndurance;
  final FlexibilityTests flexibilityTests;

  const SaveCardioFitness({
    required this.time,
    required this.distance,
    required this.pulse,
    required this.vo2max,
    required this.rockportFitnessCategory,
    required this.ymcaHeartRate,
    required this.ymcaFitnessCategory,
    required this.date,
    required this.vitalSigns,
    required this.bodyMeasurements,
    required this.muscularEndurance,
    required this.flexibilityTests,
  });

  @override
  List<Object> get props => [
        time,
        distance,
        pulse,
        vo2max,
        rockportFitnessCategory,
        ymcaHeartRate,
        ymcaFitnessCategory,
        date,
        vitalSigns,
        bodyMeasurements,
        muscularEndurance,
        flexibilityTests,
      ];
}
