import 'package:equatable/equatable.dart';

class FlexibilityTests extends Equatable {
  final bool quadriceps;
  final bool hamstring;
  final bool hipFlexors;
  final bool shoulderMobility;
  final bool sitAndReach;

  const FlexibilityTests({
    required this.quadriceps,
    required this.hamstring,
    required this.hipFlexors,
    required this.shoulderMobility,
    required this.sitAndReach,
  });

  @override
  List<Object> get props => [
        quadriceps,
        hamstring,
        hipFlexors,
        shoulderMobility,
        sitAndReach,
      ];
}
