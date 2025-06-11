import 'package:equatable/equatable.dart';

class ProgressReport extends Equatable {
  final String memberId;
  final String memberName;
  final String memberAvatar;
  final double initialWeight;
  final double currentWeight;
  final double weightChange;
  final double initialBodyFat;
  final double currentBodyFat;
  final double bodyFatChange;
  final int totalWorkouts;
  final int totalNutritionSessions;
  final double adherenceRate;
  final List<WeightEntry> weightHistory;
  final List<BodyFatEntry> bodyFatHistory;
  final List<String> achievements;

  const ProgressReport({
    required this.memberId,
    required this.memberName,
    required this.memberAvatar,
    required this.initialWeight,
    required this.currentWeight,
    required this.weightChange,
    required this.initialBodyFat,
    required this.currentBodyFat,
    required this.bodyFatChange,
    required this.totalWorkouts,
    required this.totalNutritionSessions,
    required this.adherenceRate,
    required this.weightHistory,
    required this.bodyFatHistory,
    required this.achievements,
  });

  @override
  List<Object?> get props => [
        memberId,
        memberName,
        memberAvatar,
        initialWeight,
        currentWeight,
        weightChange,
        initialBodyFat,
        currentBodyFat,
        bodyFatChange,
        totalWorkouts,
        totalNutritionSessions,
        adherenceRate,
        weightHistory,
        bodyFatHistory,
        achievements,
      ];
}

class WeightEntry extends Equatable {
  final DateTime date;
  final double weight;

  const WeightEntry({
    required this.date,
    required this.weight,
  });

  @override
  List<Object?> get props => [date, weight];
}

class BodyFatEntry extends Equatable {
  final DateTime date;
  final double percentage;

  const BodyFatEntry({
    required this.date,
    required this.percentage,
  });

  @override
  List<Object?> get props => [date, percentage];
}
