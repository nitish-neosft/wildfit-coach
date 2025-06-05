import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/assessment.dart';

part 'assessment_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AssessmentModel extends Assessment {
  @JsonKey(
    fromJson: _assessmentTypeFromJson,
    toJson: _assessmentTypeToJson,
  )
  @override
  final AssessmentType type;

  const AssessmentModel({
    required String id,
    required DateTime date,
    required this.type,
    required Map<String, dynamic> data,
  }) : super(
          id: id,
          date: date,
          type: type,
          data: data,
        );

  factory AssessmentModel.fromJson(Map<String, dynamic> json) =>
      _$AssessmentModelFromJson(json);

  static AssessmentModel fromEntity(Assessment entity) {
    return AssessmentModel(
      id: entity.id,
      date: entity.date,
      type: entity.type,
      data: entity.data,
    );
  }

  Map<String, dynamic> toJson() => _$AssessmentModelToJson(this);

  static AssessmentType _assessmentTypeFromJson(String value) =>
      AssessmentType.values.firstWhere(
        (type) => type.toString().split('.').last == value,
        orElse: () => AssessmentType.detailedMeasurements,
      );

  static String _assessmentTypeToJson(AssessmentType type) =>
      type.toString().split('.').last;
}
