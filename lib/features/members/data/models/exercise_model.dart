import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/workout_plan.dart';

part 'exercise_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ExerciseModel extends Exercise {
  @JsonKey(fromJson: _durationFromJson, toJson: _durationToJson)
  @override
  final Duration? duration;

  const ExerciseModel({
    required String id,
    required String name,
    required String type,
    required int sets,
    required int reps,
    double? weight,
    this.duration,
    Map<String, dynamic>? metadata,
  }) : super(
          id: id,
          name: name,
          type: type,
          sets: sets,
          reps: reps,
          weight: weight,
          duration: duration,
          metadata: metadata,
        );

  factory ExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseModelFromJson(json);

  factory ExerciseModel.fromEntity(Exercise entity) {
    return ExerciseModel(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      sets: entity.sets,
      reps: entity.reps,
      weight: entity.weight,
      duration: entity.duration,
      metadata: entity.metadata,
    );
  }

  Map<String, dynamic> toJson() => _$ExerciseModelToJson(this);

  static Duration? _durationFromJson(int? milliseconds) =>
      milliseconds != null ? Duration(milliseconds: milliseconds) : null;

  static int? _durationToJson(Duration? duration) => duration?.inMilliseconds;
}
