import 'package:equatable/equatable.dart';

class CardioFitness extends Equatable {
  final double vo2Max;
  final String rockportTestResult;
  final String ymcaStepTestResult;
  final int ymcaHeartRate;

  const CardioFitness({
    required this.vo2Max,
    required this.rockportTestResult,
    required this.ymcaStepTestResult,
    required this.ymcaHeartRate,
  });

  @override
  List<Object> get props => [
        vo2Max,
        rockportTestResult,
        ymcaStepTestResult,
        ymcaHeartRate,
      ];
}
