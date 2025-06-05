import 'package:equatable/equatable.dart';

enum AssessmentType {
  bloodPressure,
  cardioFitness,
  muscularFlexibility,
  detailedMeasurements,
}

class Assessment extends Equatable {
  final String id;
  final DateTime date;
  final AssessmentType type;
  final Map<String, dynamic> data;

  const Assessment({
    required this.id,
    required this.date,
    required this.type,
    required this.data,
  });

  @override
  List<Object> get props => [id, date, type, data];
}
