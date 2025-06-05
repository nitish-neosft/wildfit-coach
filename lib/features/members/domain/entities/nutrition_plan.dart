import 'package:equatable/equatable.dart';
import 'meal.dart';
import 'supplement.dart';

class NutritionPlan extends Equatable {
  final String id;
  final String memberId;
  final String name;
  final String type;
  final int dailyCalories;
  final int mealsPerDay;
  final int durationWeeks;
  final int currentProtein;
  final int targetProtein;
  final int currentCarbs;
  final int targetCarbs;
  final int currentFats;
  final int targetFats;
  final List<Meal> meals;
  final List<Supplement> supplements;

  const NutritionPlan({
    required this.id,
    required this.memberId,
    required this.name,
    required this.type,
    required this.dailyCalories,
    required this.mealsPerDay,
    required this.durationWeeks,
    required this.currentProtein,
    required this.targetProtein,
    required this.currentCarbs,
    required this.targetCarbs,
    required this.currentFats,
    required this.targetFats,
    required this.meals,
    required this.supplements,
  });

  NutritionPlan copyWith({
    String? id,
    String? memberId,
    String? name,
    String? type,
    int? dailyCalories,
    int? mealsPerDay,
    int? durationWeeks,
    int? currentProtein,
    int? targetProtein,
    int? currentCarbs,
    int? targetCarbs,
    int? currentFats,
    int? targetFats,
    List<Meal>? meals,
    List<Supplement>? supplements,
  }) {
    return NutritionPlan(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      name: name ?? this.name,
      type: type ?? this.type,
      dailyCalories: dailyCalories ?? this.dailyCalories,
      mealsPerDay: mealsPerDay ?? this.mealsPerDay,
      durationWeeks: durationWeeks ?? this.durationWeeks,
      currentProtein: currentProtein ?? this.currentProtein,
      targetProtein: targetProtein ?? this.targetProtein,
      currentCarbs: currentCarbs ?? this.currentCarbs,
      targetCarbs: targetCarbs ?? this.targetCarbs,
      currentFats: currentFats ?? this.currentFats,
      targetFats: targetFats ?? this.targetFats,
      meals: meals ?? this.meals,
      supplements: supplements ?? this.supplements,
    );
  }

  @override
  List<Object?> get props => [
        id,
        memberId,
        name,
        type,
        dailyCalories,
        mealsPerDay,
        durationWeeks,
        currentProtein,
        targetProtein,
        currentCarbs,
        targetCarbs,
        currentFats,
        targetFats,
        meals,
        supplements,
      ];
}
