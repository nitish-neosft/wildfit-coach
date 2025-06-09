import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/cardio_fitness.dart';

part 'cardio_fitness_model.g.dart';

@JsonSerializable()
class CardioFitnessModel extends CardioFitness {
  const CardioFitnessModel({
    required double vo2Max,
    required String rockportTestResult,
    required String ymcaStepTestResult,
    required int ymcaHeartRate,
  }) : super(
          vo2Max: vo2Max,
          rockportTestResult: rockportTestResult,
          ymcaStepTestResult: ymcaStepTestResult,
          ymcaHeartRate: ymcaHeartRate,
        );

  factory CardioFitnessModel.empty() {
    return const CardioFitnessModel(
      vo2Max: 0,
      rockportTestResult: '',
      ymcaStepTestResult: '',
      ymcaHeartRate: 0,
    );
  }

  factory CardioFitnessModel.fromJson(Map<String, dynamic> json) =>
      _$CardioFitnessModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardioFitnessModelToJson(this);

  factory CardioFitnessModel.fromEntity(CardioFitness entity) {
    return CardioFitnessModel(
      vo2Max: entity.vo2Max,
      rockportTestResult: entity.rockportTestResult,
      ymcaStepTestResult: entity.ymcaStepTestResult,
      ymcaHeartRate: entity.ymcaHeartRate,
    );
  }

  CardioFitness toEntity() {
    return CardioFitness(
      vo2Max: vo2Max,
      rockportTestResult: rockportTestResult,
      ymcaStepTestResult: ymcaStepTestResult,
      ymcaHeartRate: ymcaHeartRate,
    );
  }
}
