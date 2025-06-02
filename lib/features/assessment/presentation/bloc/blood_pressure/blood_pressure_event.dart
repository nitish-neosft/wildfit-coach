part of 'blood_pressure_bloc.dart';

abstract class BloodPressureEvent extends Equatable {
  const BloodPressureEvent();

  @override
  List<Object?> get props => [];
}

class UpdateBPCategory extends BloodPressureEvent {
  final String category;

  const UpdateBPCategory(this.category);

  @override
  List<Object> get props => [category];
}

class SaveBloodPressure extends BloodPressureEvent {
  final int systolic;
  final int diastolic;
  final int pulse;
  final int restingHeartRate;
  final String bpCategory;
  final DateTime date;

  const SaveBloodPressure({
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    required this.restingHeartRate,
    required this.bpCategory,
    required this.date,
  });

  @override
  List<Object> get props => [
        systolic,
        diastolic,
        pulse,
        restingHeartRate,
        bpCategory,
        date,
      ];
}
