import 'package:equatable/equatable.dart';

enum NutritionPlanType {
  weightLoss,
  maintenance,
  muscleGain,
  ketogenic,
  vegetarian,
  vegan,
  paleo,
  custom
}

class NutritionPlan extends Equatable {
  final String id;
  final String memberId;
  final String name;
  final String description;
  final NutritionPlanType type;
  final bool isActive;
  final DateTime startDate;
  final DateTime? endDate;
  final int dailyCalorieTarget;
  final Map<String, double> macroTargets; // protein, carbs, fats in grams
  final List<String> dietaryRestrictions;
  final List<String> allowedFoods;
  final List<String> excludedFoods;

  const NutritionPlan({
    required this.id,
    required this.memberId,
    required this.name,
    required this.description,
    required this.type,
    required this.isActive,
    required this.startDate,
    this.endDate,
    required this.dailyCalorieTarget,
    required this.macroTargets,
    required this.dietaryRestrictions,
    required this.allowedFoods,
    required this.excludedFoods,
  });

  @override
  List<Object?> get props => [
        id,
        memberId,
        name,
        description,
        type,
        isActive,
        startDate,
        endDate,
        dailyCalorieTarget,
        macroTargets,
        dietaryRestrictions,
        allowedFoods,
        excludedFoods,
      ];

  NutritionPlan copyWith({
    String? id,
    String? memberId,
    String? name,
    String? description,
    NutritionPlanType? type,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
    int? dailyCalorieTarget,
    Map<String, double>? macroTargets,
    List<String>? dietaryRestrictions,
    List<String>? allowedFoods,
    List<String>? excludedFoods,
  }) {
    return NutritionPlan(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dailyCalorieTarget: dailyCalorieTarget ?? this.dailyCalorieTarget,
      macroTargets: macroTargets ?? this.macroTargets,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
      allowedFoods: allowedFoods ?? this.allowedFoods,
      excludedFoods: excludedFoods ?? this.excludedFoods,
    );
  }
}
