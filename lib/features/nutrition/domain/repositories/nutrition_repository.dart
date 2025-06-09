import '../entities/nutrition_plan.dart';

abstract class NutritionRepository {
  Future<List<NutritionPlan>> getNutritionPlans();
  Future<List<NutritionPlan>> getMemberNutritionPlans(String memberId);
  Future<NutritionPlan?> getNutritionPlanById(String id);
  Future<void> createNutritionPlan(NutritionPlan plan);
  Future<void> updateNutritionPlan(NutritionPlan plan);
  Future<void> deleteNutritionPlan(String id);
}
