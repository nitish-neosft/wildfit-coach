part of 'blood_pressure_bloc.dart';

abstract class BloodPressureEvent extends Equatable {
  const BloodPressureEvent();

  @override
  List<Object> get props => [];
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
  final int restingHeartRate;
  final String bpCategory;

  const SaveBloodPressure({
    required this.systolic,
    required this.diastolic,
    required this.restingHeartRate,
    required this.bpCategory,
  });

  @override
  List<Object> get props => [systolic, diastolic, restingHeartRate, bpCategory];
}
