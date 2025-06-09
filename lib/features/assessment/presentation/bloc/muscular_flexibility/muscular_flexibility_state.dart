part of 'muscular_flexibility_bloc.dart';

abstract class MuscularFlexibilityState extends Equatable {
  const MuscularFlexibilityState();

  @override
  List<Object> get props => [];
}

class MuscularFlexibilityInitial extends MuscularFlexibilityState {
  final String? pushUpType;
  final String? squatType;
  final Map<String, bool> flexibilityTests;

  const MuscularFlexibilityInitial({
    this.pushUpType,
    this.squatType,
    Map<String, bool>? flexibilityTests,
  }) : flexibilityTests = flexibilityTests ??
            const {
              'quadriceps': false,
              'hamstring': false,
              'hipFlexors': false,
              'shoulderMobility': false,
              'sitAndReach': false,
            };

  @override
  List<Object> get props => [
        pushUpType ?? '',
        squatType ?? '',
        flexibilityTests,
      ];

  MuscularFlexibilityInitial copyWith({
    String? pushUpType,
    String? squatType,
    Map<String, bool>? flexibilityTests,
  }) {
    return MuscularFlexibilityInitial(
      pushUpType: pushUpType ?? this.pushUpType,
      squatType: squatType ?? this.squatType,
      flexibilityTests: flexibilityTests ?? this.flexibilityTests,
    );
  }
}

class MuscularFlexibilitySaving extends MuscularFlexibilityState {}

class MuscularFlexibilitySaved extends MuscularFlexibilityState {}

class MuscularFlexibilityError extends MuscularFlexibilityState {
  final String message;

  const MuscularFlexibilityError(this.message);

  @override
  List<Object> get props => [message];
}
