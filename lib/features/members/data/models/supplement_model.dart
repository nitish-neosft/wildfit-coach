import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/supplement.dart';

part 'supplement_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SupplementModel extends Supplement {
  const SupplementModel({
    required String id,
    required String name,
    required String type,
    required String dosage,
    required String frequency,
    Map<String, dynamic>? instructions,
  }) : super(
          id: id,
          name: name,
          type: type,
          dosage: dosage,
          frequency: frequency,
          instructions: instructions,
        );

  factory SupplementModel.fromJson(Map<String, dynamic> json) =>
      _$SupplementModelFromJson(json);

  factory SupplementModel.fromEntity(Supplement entity) {
    return SupplementModel(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      dosage: entity.dosage,
      frequency: entity.frequency,
      instructions: entity.instructions,
    );
  }

  Map<String, dynamic> toJson() => _$SupplementModelToJson(this);
}
