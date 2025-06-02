import 'package:equatable/equatable.dart';

class MuscularEndurance extends Equatable {
  final int pushUps;
  final String pushUpType;
  final int squats;
  final String squatType;
  final int pullUps;

  const MuscularEndurance({
    required this.pushUps,
    required this.pushUpType,
    required this.squats,
    required this.squatType,
    required this.pullUps,
  });

  @override
  List<Object> get props => [
        pushUps,
        pushUpType,
        squats,
        squatType,
        pullUps,
      ];
}
