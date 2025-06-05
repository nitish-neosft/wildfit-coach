import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/workout_plan.dart';
import 'exercise_model.dart';

part 'workout_session_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class WorkoutSessionModel extends WorkoutSession {
  @override
  final List<ExerciseModel> exercises;

  @JsonKey(fromJson: _durationFromJson, toJson: _durationToJson)
  @override
  final Duration duration;

  const WorkoutSessionModel({
    required String id,
    required String name,
    required String type,
    required int dayOfWeek,
    required this.duration,
    required this.exercises,
    String? notes,
  }) : super(
          id: id,
          name: name,
          type: type,
          dayOfWeek: dayOfWeek,
          duration: duration,
          exercises: exercises,
          notes: notes,
        );

  factory WorkoutSessionModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSessionModelFromJson(json);

  factory WorkoutSessionModel.fromEntity(WorkoutSession entity) {
    return WorkoutSessionModel(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      dayOfWeek: entity.dayOfWeek,
      duration: entity.duration,
      exercises: entity.exercises
          .map((exercise) => ExerciseModel.fromEntity(exercise))
          .toList(),
      notes: entity.notes,
    );
  }

  Map<String, dynamic> toJson() => _$WorkoutSessionModelToJson(this);

  static Duration _durationFromJson(int milliseconds) =>
      Duration(milliseconds: milliseconds);

  static int _durationToJson(Duration duration) => duration.inMilliseconds;
}
