part of 'blood_pressure_bloc.dart';

abstract class BloodPressureState extends Equatable {
  const BloodPressureState();

  @override
  List<Object?> get props => [];
}

class BloodPressureInitial extends BloodPressureState {
  final String bpCategory;

  const BloodPressureInitial({
    this.bpCategory = 'Normal',
  });

  @override
  List<Object> get props => [bpCategory];

  BloodPressureInitial copyWith({
    String? bpCategory,
  }) {
    return BloodPressureInitial(
      bpCategory: bpCategory ?? this.bpCategory,
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
