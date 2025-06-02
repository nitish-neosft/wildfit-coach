import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/muscular_endurance.dart';

part 'muscular_endurance_model.g.dart';

@JsonSerializable()
class MuscularEnduranceModel {
  final int pushUps;
  final String pushUpType;
  final int squats;
  final String squatType;
  final int pullUps;

  MuscularEnduranceModel({
    required this.pushUps,
    required this.pushUpType,
    required this.squats,
    required this.squatType,
    required this.pullUps,
  });

  factory MuscularEnduranceModel.fromJson(Map<String, dynamic> json) =>
      _$MuscularEnduranceModelFromJson(json);

  Map<String, dynamic> toJson() => _$MuscularEnduranceModelToJson(this);

  factory MuscularEnduranceModel.fromEntity(MuscularEndurance entity) {
    return MuscularEnduranceModel(
      pushUps: entity.pushUps,
      pushUpType: entity.pushUpType,
      squats: entity.squats,
      squatType: entity.squatType,
      pullUps: entity.pullUps,
    );
  }

  MuscularEndurance toEntity() {
    return MuscularEndurance(
      pushUps: pushUps,
      pushUpType: pushUpType,
      squats: squats,
      squatType: squatType,
      pullUps: pullUps,
    );
  }
}
