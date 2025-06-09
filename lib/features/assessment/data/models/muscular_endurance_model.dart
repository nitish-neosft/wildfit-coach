import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/muscular_endurance.dart';

part 'muscular_endurance_model.g.dart';

@JsonSerializable()
class MuscularEnduranceModel extends MuscularEndurance {
  const MuscularEnduranceModel({
    required int pushUps,
    required String pushUpType,
    required int squats,
    required String squatType,
    required int pullUps,
  }) : super(
          pushUps: pushUps,
          pushUpType: pushUpType,
          squats: squats,
          squatType: squatType,
          pullUps: pullUps,
        );

  factory MuscularEnduranceModel.empty() {
    return const MuscularEnduranceModel(
      pushUps: 0,
      pushUpType: '',
      pullUps: 0,
      squats: 0,
      squatType: '',
    );
  }

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
