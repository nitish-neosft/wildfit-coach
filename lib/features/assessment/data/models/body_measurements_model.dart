import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/body_measurements.dart';

part 'body_measurements_model.g.dart';

@JsonSerializable()
class BodyMeasurementsModel extends BodyMeasurements {
  const BodyMeasurementsModel({
    required double height,
    required double weight,
    required double chest,
    required double waist,
    required double hips,
    required double arms,
    required double neck,
    required double forearm,
    required double calf,
    required double midThigh,
  }) : super(
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

  factory BodyMeasurementsModel.empty() {
    return const BodyMeasurementsModel(
      height: 0,
      weight: 0,
      chest: 0,
      waist: 0,
      hips: 0,
      arms: 0,
      neck: 0,
      forearm: 0,
      calf: 0,
      midThigh: 0,
    );
  }

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
