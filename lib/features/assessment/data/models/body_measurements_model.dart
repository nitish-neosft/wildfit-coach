import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/body_measurements.dart';

part 'body_measurements_model.g.dart';

@JsonSerializable()
class BodyMeasurementsModel {
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

  BodyMeasurementsModel({
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

  factory BodyMeasurementsModel.fromJson(Map<String, dynamic> json) =>
      _$BodyMeasurementsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BodyMeasurementsModelToJson(this);

  factory BodyMeasurementsModel.fromEntity(BodyMeasurements entity) {
    return BodyMeasurementsModel(
      height: entity.height,
      weight: entity.weight,
      chest: entity.chest,
      waist: entity.waist,
      hips: entity.hips,
      arms: entity.arms,
      neck: entity.neck,
      forearm: entity.forearm,
      calf: entity.calf,
      midThigh: entity.midThigh,
    );
  }

  BodyMeasurements toEntity() {
    return BodyMeasurements(
      height: height,
      weight: weight,
      chest: chest,
      waist: waist,
      hips: hips,
      arms: arms,
      neck: neck,
      forearm: forearm,
      calf: calf,
      midThigh: midThigh,
    );
  }
}
