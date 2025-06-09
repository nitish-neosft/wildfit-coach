part of 'cardio_fitness_bloc.dart';

abstract class CardioFitnessEvent extends Equatable {
  const CardioFitnessEvent();

  @override
  List<Object> get props => [];
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
  final VitalSigns vitalSigns;
  final CardioFitness cardioFitness;

  const SaveCardioFitness({
    required this.vitalSigns,
    required this.cardioFitness,
  });

  @override
  List<Object> get props => [vitalSigns, cardioFitness];
}
