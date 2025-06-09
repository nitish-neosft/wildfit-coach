part of 'blood_pressure_bloc.dart';

abstract class BloodPressureState extends Equatable {
  const BloodPressureState();

  @override
  List<Object> get props => [];
}

class BloodPressureInitial extends BloodPressureState {
  final String bpCategory;
  final int systolic;
  final int diastolic;
  final int restingHeartRate;

  const BloodPressureInitial({
    required this.bpCategory,
    required this.systolic,
    required this.diastolic,
    required this.restingHeartRate,
  });

  @override
  List<Object> get props => [bpCategory, systolic, diastolic, restingHeartRate];

  BloodPressureInitial copyWith({
    String? bpCategory,
    int? systolic,
    int? diastolic,
    int? restingHeartRate,
  }) {
    return BloodPressureInitial(
      bpCategory: bpCategory ?? this.bpCategory,
      systolic: systolic ?? this.systolic,
      diastolic: diastolic ?? this.diastolic,
      restingHeartRate: restingHeartRate ?? this.restingHeartRate,
    );
  }
}

class BloodPressureSaving extends BloodPressureState {}

class BloodPressureSaved extends BloodPressureState {}

class BloodPressureError extends BloodPressureState {
  final String message;

  const BloodPressureError(this.message);

  @override
  List<Object> get props => [message];
}
