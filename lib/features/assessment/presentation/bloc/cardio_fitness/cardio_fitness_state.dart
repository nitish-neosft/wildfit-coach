part of 'cardio_fitness_bloc.dart';

abstract class CardioFitnessState extends Equatable {
  const CardioFitnessState();

  @override
  List<Object?> get props => [];
}

class CardioFitnessInitial extends CardioFitnessState {
  final String rockportFitnessCategory;
  final String ymcaFitnessCategory;

  const CardioFitnessInitial({
    this.rockportFitnessCategory = 'Average',
    this.ymcaFitnessCategory = 'Average',
  });

  @override
  List<Object> get props => [rockportFitnessCategory, ymcaFitnessCategory];

  CardioFitnessInitial copyWith({
    String? rockportFitnessCategory,
    String? ymcaFitnessCategory,
  }) {
    return CardioFitnessInitial(
      rockportFitnessCategory:
          rockportFitnessCategory ?? this.rockportFitnessCategory,
      ymcaFitnessCategory: ymcaFitnessCategory ?? this.ymcaFitnessCategory,
    );
  }
}

class CardioFitnessSaving extends CardioFitnessState {}

class CardioFitnessSaved extends CardioFitnessState {}

class CardioFitnessError extends CardioFitnessState {
  final String message;

  const CardioFitnessError(this.message);

  @override
  List<Object> get props => [message];
}
