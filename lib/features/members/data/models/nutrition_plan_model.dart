import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/nutrition_plan.dart';
import '../../domain/entities/meal.dart';
import '../../domain/entities/supplement.dart';
import 'meal_model.dart';
import 'supplement_model.dart';

part 'nutrition_plan_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class NutritionPlanModel extends NutritionPlan {
  @override
  final List<MealModel> meals;

  @override
  final List<SupplementModel> supplements;

  const NutritionPlanModel({
    required String id,
    required String memberId,
    required String name,
    required String type,
    required int dailyCalories,
    required int mealsPerDay,
    required int durationWeeks,
    required int currentProtein,
    required int targetProtein,
    required int currentCarbs,
    required int targetCarbs,
    required int currentFats,
    required int targetFats,
    required this.meals,
    required this.supplements,
  }) : super(
          id: id,
          memberId: memberId,
          name: name,
          type: type,
          dailyCalories: dailyCalories,
          mealsPerDay: mealsPerDay,
          durationWeeks: durationWeeks,
          currentProtein: currentProtein,
          targetProtein: targetProtein,
          currentCarbs: currentCarbs,
          targetCarbs: targetCarbs,
          currentFats: currentFats,
          targetFats: targetFats,
          meals: meals,
          supplements: supplements,
        );

  factory NutritionPlanModel.fromJson(Map<String, dynamic> json) =>
      _$NutritionPlanModelFromJson(json);

  factory NutritionPlanModel.fromEntity(NutritionPlan entity) {
    return NutritionPlanModel(
      id: entity.id,
      memberId: entity.memberId,
      name: entity.name,
      type: entity.type,
      dailyCalories: entity.dailyCalories,
      mealsPerDay: entity.mealsPerDay,
      durationWeeks: entity.durationWeeks,
      currentProtein: entity.currentProtein,
      targetProtein: entity.targetProtein,
      currentCarbs: entity.currentCarbs,
      targetCarbs: entity.targetCarbs,
      currentFats: entity.currentFats,
      targetFats: entity.targetFats,
      meals: entity.meals.map((meal) => MealModel.fromEntity(meal)).toList(),
      supplements: entity.supplements
          .map((supplement) => SupplementModel.fromEntity(supplement))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$NutritionPlanModelToJson(this);
}
