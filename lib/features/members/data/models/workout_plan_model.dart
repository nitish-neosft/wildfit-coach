import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/workout_plan.dart';
import 'workout_session_model.dart';

part 'workout_plan_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class WorkoutPlanModel extends WorkoutPlan {
  @override
  final List<WorkoutSessionModel> sessions;

  const WorkoutPlanModel({
    required String id,
    required String memberId,
    required String name,
    required String type,
    required int durationWeeks,
    required int sessionsPerWeek,
    required this.sessions,
    Map<String, dynamic>? goals,
    Map<String, dynamic>? progress,
  }) : super(
          id: id,
          memberId: memberId,
          name: name,
          type: type,
          durationWeeks: durationWeeks,
          sessionsPerWeek: sessionsPerWeek,
          sessions: sessions,
          goals: goals,
          progress: progress,
        );

  factory WorkoutPlanModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanModelFromJson(json);

  factory WorkoutPlanModel.fromEntity(WorkoutPlan entity) {
    return WorkoutPlanModel(
      id: entity.id,
      memberId: entity.memberId,
      name: entity.name,
      type: entity.type,
      durationWeeks: entity.durationWeeks,
      sessionsPerWeek: entity.sessionsPerWeek,
      sessions: entity.sessions
          .map((session) => WorkoutSessionModel.fromEntity(session))
          .toList(),
      goals: entity.goals,
      progress: entity.progress,
    );
  }

  Map<String, dynamic> toJson() => _$WorkoutPlanModelToJson(this);
}
