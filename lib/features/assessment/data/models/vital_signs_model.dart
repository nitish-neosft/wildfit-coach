import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/vital_signs.dart';

part 'vital_signs_model.g.dart';

@JsonSerializable()
class VitalSignsModel extends VitalSigns {
  const VitalSignsModel({
    required String bloodPressure,
    required int restingHeartRate,
    required String bpCategory,
  }) : super(
          bloodPressure: bloodPressure,
          restingHeartRate: restingHeartRate,
          bpCategory: bpCategory,
        );

  factory VitalSignsModel.fromJson(Map<String, dynamic> json) =>
      _$VitalSignsModelFromJson(json);

  Map<String, dynamic> toJson() => _$VitalSignsModelToJson(this);

  factory VitalSignsModel.fromEntity(VitalSigns entity) {
    return VitalSignsModel(
      bloodPressure: entity.bloodPressure,
      restingHeartRate: entity.restingHeartRate,
      bpCategory: entity.bpCategory,
    );
  }

  VitalSigns toEntity() {
    return VitalSigns(
      bloodPressure: bloodPressure,
      restingHeartRate: restingHeartRate,
      bpCategory: bpCategory,
    );
  }
}
