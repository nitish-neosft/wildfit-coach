import '../entities/nutrition_plan.dart';
import '../entities/member_nutrition_status.dart';

abstract class NutritionRepository {
  Future<List<NutritionPlan>> getNutritionPlans();
  Future<List<NutritionPlan>> getMemberNutritionPlans(String memberId);
  Future<NutritionPlan?> getNutritionPlanById(String id);
  Future<void> createNutritionPlan(NutritionPlan plan);
  Future<void> updateNutritionPlan(NutritionPlan plan);
  Future<void> deleteNutritionPlan(String id);
  Future<List<MemberNutritionStatus>> getMembersNeedingPlans();
  Future<void> assignNutritionPlan(String planId, String memberId);
}
