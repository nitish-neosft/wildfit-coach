part of 'detailed_measurements_bloc.dart';

abstract class DetailedMeasurementsEvent extends Equatable {
  const DetailedMeasurementsEvent();

  @override
  List<Object?> get props => [];
}

class SaveDetailedMeasurements extends DetailedMeasurementsEvent {
  final double height;
  final double weight;
  final double arms;
  final double calf;
  final double forearm;
  final double midThigh;
  final double chest;
  final double waist;
  final double hips;
  final double neck;
  final DateTime date;

  const SaveDetailedMeasurements({
    required this.height,
    required this.weight,
    required this.arms,
    required this.calf,
    required this.forearm,
    required this.midThigh,
    required this.chest,
    required this.waist,
    required this.hips,
    required this.neck,
    required this.date,
  });

  @override
  List<Object> get props => [
        height,
        weight,
        arms,
        calf,
        forearm,
        midThigh,
        chest,
        waist,
        hips,
        neck,
        date,
      ];
}
