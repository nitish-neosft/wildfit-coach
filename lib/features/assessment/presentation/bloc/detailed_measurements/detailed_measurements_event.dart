part of 'detailed_measurements_bloc.dart';

abstract class DetailedMeasurementsEvent extends Equatable {
  const DetailedMeasurementsEvent();

  @override
  List<Object> get props => [];
}

class SaveDetailedMeasurements extends DetailedMeasurementsEvent {
  final VitalSigns vitalSigns;
  final BodyMeasurements bodyMeasurements;

  const SaveDetailedMeasurements({
    required this.vitalSigns,
    required this.bodyMeasurements,
  });

  @override
  List<Object> get props => [vitalSigns, bodyMeasurements];
}
