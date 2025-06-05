import '../entities/nutrition_plan.dart';

abstract class NutritionPlanRepository {
  Future<List<NutritionPlan>> getNutritionPlans(String memberId);
  Future<NutritionPlan> getNutritionPlan(String id);
  Future<NutritionPlan> createNutritionPlan(NutritionPlan nutritionPlan);
  Future<void> updateNutritionPlan(NutritionPlan nutritionPlan);
  Future<void> deleteNutritionPlan(String id);
  Future<void> assignNutritionPlan(String memberId, String nutritionPlanId);
  Future<void> unassignNutritionPlan(String memberId, String nutritionPlanId);
  Future<void> updateMacros(
    String id, {
    required int currentProtein,
    required int currentCarbs,
    required int currentFats,
  });
}
