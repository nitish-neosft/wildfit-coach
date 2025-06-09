import 'package:equatable/equatable.dart';
import '../../domain/entities/nutrition_plan.dart';

class NutritionPlanModel extends Equatable {
  final String id;
  final String memberId;
  final String name;
  final String description;
  final NutritionPlanType type;
  final bool isActive;
  final DateTime startDate;
  final DateTime? endDate;
  final int dailyCalorieTarget;
  final Map<String, double> macroTargets;
  final List<String> dietaryRestrictions;
  final List<String> allowedFoods;
  final List<String> excludedFoods;

  const NutritionPlanModel({
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

  factory NutritionPlanModel.fromJson(Map<String, dynamic> json) {
    return NutritionPlanModel(
      id: json['id'] as String,
      memberId: json['member_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: _parseNutritionPlanType(json['type'] as String),
      isActive: json['is_active'] as bool,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'] as String)
          : null,
      dailyCalorieTarget: json['daily_calorie_target'] as int,
      macroTargets: Map<String, double>.from(json['macro_targets'] as Map),
      dietaryRestrictions:
          List<String>.from(json['dietary_restrictions'] as List),
      allowedFoods: List<String>.from(json['allowed_foods'] as List),
      excludedFoods: List<String>.from(json['excluded_foods'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'member_id': memberId,
      'name': name,
      'description': description,
      'type': type.toString().split('.').last,
      'is_active': isActive,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'daily_calorie_target': dailyCalorieTarget,
      'macro_targets': macroTargets,
      'dietary_restrictions': dietaryRestrictions,
      'allowed_foods': allowedFoods,
      'excluded_foods': excludedFoods,
    };
  }

  factory NutritionPlanModel.fromEntity(NutritionPlan entity) {
    return NutritionPlanModel(
      id: entity.id,
      memberId: entity.memberId,
      name: entity.name,
      description: entity.description,
      type: entity.type,
      isActive: entity.isActive,
      startDate: entity.startDate,
      endDate: entity.endDate,
      dailyCalorieTarget: entity.dailyCalorieTarget,
      macroTargets: Map<String, double>.from(entity.macroTargets),
      dietaryRestrictions: List<String>.from(entity.dietaryRestrictions),
      allowedFoods: List<String>.from(entity.allowedFoods),
      excludedFoods: List<String>.from(entity.excludedFoods),
    );
  }

  NutritionPlan toEntity() {
    return NutritionPlan(
      id: id,
      memberId: memberId,
      name: name,
      description: description,
      type: type,
      isActive: isActive,
      startDate: startDate,
      endDate: endDate,
      dailyCalorieTarget: dailyCalorieTarget,
      macroTargets: Map<String, double>.from(macroTargets),
      dietaryRestrictions: List<String>.from(dietaryRestrictions),
      allowedFoods: List<String>.from(allowedFoods),
      excludedFoods: List<String>.from(excludedFoods),
    );
  }

  static NutritionPlanType _parseNutritionPlanType(String type) {
    switch (type) {
      case 'weightLoss':
        return NutritionPlanType.weightLoss;
      case 'maintenance':
        return NutritionPlanType.maintenance;
      case 'muscleGain':
        return NutritionPlanType.muscleGain;
      case 'ketogenic':
        return NutritionPlanType.ketogenic;
      case 'vegetarian':
        return NutritionPlanType.vegetarian;
      case 'vegan':
        return NutritionPlanType.vegan;
      case 'paleo':
        return NutritionPlanType.paleo;
      default:
        return NutritionPlanType.custom;
    }
  }

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
}
