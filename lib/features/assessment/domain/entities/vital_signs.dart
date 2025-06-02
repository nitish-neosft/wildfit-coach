import 'package:equatable/equatable.dart';

class VitalSigns extends Equatable {
  final String bloodPressure;
  final int restingHeartRate;
  final String bpCategory;

  const VitalSigns({
    required this.bloodPressure,
    required this.restingHeartRate,
    required this.bpCategory,
  });

  @override
  List<Object> get props => [
        bloodPressure,
        restingHeartRate,
        bpCategory,
      ];
}
