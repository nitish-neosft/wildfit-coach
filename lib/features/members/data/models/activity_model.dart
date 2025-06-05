import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/activity.dart';

part 'activity_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ActivityModel extends Activity {
  @JsonKey(
    fromJson: _activityTypeFromJson,
    toJson: _activityTypeToJson,
  )
  @override
  final ActivityType type;

  const ActivityModel({
    required String name,
    required this.type,
    required DateTime time,
    Map<String, dynamic>? data,
  }) : super(
          name: name,
          type: type,
          time: time,
          data: data,
        );

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  static ActivityModel fromEntity(Activity entity) {
    return ActivityModel(
      name: entity.name,
      type: entity.type,
      time: entity.time,
      data: entity.data,
    );
  }

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);

  static ActivityType _activityTypeFromJson(String value) =>
      ActivityType.values.firstWhere(
        (type) => type.toString().split('.').last == value,
        orElse: () => ActivityType.other,
      );

  static String _activityTypeToJson(ActivityType type) =>
      type.toString().split('.').last;
}
