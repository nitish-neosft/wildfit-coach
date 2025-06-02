import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/cardio_fitness.dart';

part 'cardio_fitness_model.g.dart';

@JsonSerializable()
class CardioFitnessModel {
  final double vo2Max;
  final String rockportTestResult;
  final String ymcaStepTestResult;
  final int ymcaHeartRate;

  CardioFitnessModel({
    required this.vo2Max,
    required this.rockportTestResult,
    required this.ymcaStepTestResult,
    required this.ymcaHeartRate,
  });

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
