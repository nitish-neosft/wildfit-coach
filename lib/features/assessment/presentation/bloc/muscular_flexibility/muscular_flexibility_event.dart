part of 'muscular_flexibility_bloc.dart';

abstract class MuscularFlexibilityEvent extends Equatable {
  const MuscularFlexibilityEvent();

  @override
  List<Object> get props => [];
}

class UpdatePushUpType extends MuscularFlexibilityEvent {
  final String type;

  const UpdatePushUpType(this.type);

  @override
  List<Object> get props => [type];
}

class UpdateSquatType extends MuscularFlexibilityEvent {
  final String type;

  const UpdateSquatType(this.type);

  @override
  List<Object> get props => [type];
}

class UpdateFlexibilityTest extends MuscularFlexibilityEvent {
  final String test;
  final bool passed;

  const UpdateFlexibilityTest({
    required this.test,
    required this.passed,
  });

  @override
  List<Object> get props => [test, passed];
}

class SaveMuscularFlexibility extends MuscularFlexibilityEvent {
  final VitalSigns vitalSigns;
  final int pushUps;
  final String pushUpType;
  final int squats;
  final String squatType;
  final int pullUps;
  final bool quadricepsPass;
  final bool hamstringPass;
  final bool hipFlexorsPass;
  final bool shoulderMobilityPass;
  final bool sitAndReachPass;

  const SaveMuscularFlexibility({
    required this.vitalSigns,
    required this.pushUps,
    required this.pushUpType,
    required this.squats,
    required this.squatType,
    required this.pullUps,
    required this.quadricepsPass,
    required this.hamstringPass,
    required this.hipFlexorsPass,
    required this.shoulderMobilityPass,
    required this.sitAndReachPass,
  });

  @override
  List<Object> get props => [
        vitalSigns,
        pushUps,
        pushUpType,
        squats,
        squatType,
        pullUps,
        quadricepsPass,
        hamstringPass,
        hipFlexorsPass,
        shoulderMobilityPass,
        sitAndReachPass,
      ];
}
