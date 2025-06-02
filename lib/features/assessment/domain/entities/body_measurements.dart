import 'package:equatable/equatable.dart';

class BodyMeasurements extends Equatable {
  final double height;
  final double weight;
  final double chest;
  final double waist;
  final double hips;
  final double arms;
  final double neck;
  final double forearm;
  final double calf;
  final double midThigh;

  const BodyMeasurements({
    required this.height,
    required this.weight,
    required this.chest,
    required this.waist,
    required this.hips,
    required this.arms,
    required this.neck,
    required this.forearm,
    required this.calf,
    required this.midThigh,
  });

  @override
  List<Object> get props => [
        height,
        weight,
        chest,
        waist,
        hips,
        arms,
        neck,
        forearm,
        calf,
        midThigh,
      ];
}
