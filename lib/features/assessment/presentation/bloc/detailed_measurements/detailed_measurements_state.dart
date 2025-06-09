part of 'detailed_measurements_bloc.dart';

abstract class DetailedMeasurementsState extends Equatable {
  const DetailedMeasurementsState();

  @override
  List<Object> get props => [];
}

class DetailedMeasurementsInitial extends DetailedMeasurementsState {}

class DetailedMeasurementsSaving extends DetailedMeasurementsState {}

class DetailedMeasurementsSaved extends DetailedMeasurementsState {}

class DetailedMeasurementsError extends DetailedMeasurementsState {
  final String message;

  const DetailedMeasurementsError(this.message);

  @override
  List<Object> get props => [message];
}
