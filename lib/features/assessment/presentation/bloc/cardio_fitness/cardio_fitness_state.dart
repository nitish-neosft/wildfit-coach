part of 'cardio_fitness_bloc.dart';

abstract class CardioFitnessState extends Equatable {
  const CardioFitnessState();

  @override
  List<Object> get props => [];
}

class CardioFitnessInitial extends CardioFitnessState {}

class CardioFitnessSaving extends CardioFitnessState {}

class CardioFitnessSaved extends CardioFitnessState {}

class CardioFitnessError extends CardioFitnessState {
  final String message;

  const CardioFitnessError(this.message);

  @override
  List<Object> get props => [message];
}
