import '../../domain/entities/nutrition_plan.dart';
import '../../domain/repositories/nutrition_repository.dart';

class NutritionRepositoryImpl implements NutritionRepository {
  final List<NutritionPlan> _plans = [
    // Add some sample data
    NutritionPlan(
      id: '1',
      memberId: 'member1',
      name: 'Weight Loss Plan',
      description: 'A balanced plan for healthy weight loss',
      type: NutritionPlanType.weightLoss,
      isActive: true,
      startDate: DateTime.now(),
      dailyCalorieTarget: 2000,
      macroTargets: {
        'protein': 150,
        'carbs': 200,
        'fats': 70,
      },
      dietaryRestrictions: ['Gluten-free', 'Dairy-free'],
      allowedFoods: ['Chicken', 'Fish', 'Vegetables', 'Rice'],
      excludedFoods: ['Bread', 'Pasta'],
    ),
  ];

  @override
  Future<List<NutritionPlan>> getNutritionPlans() async {
    return _plans;
  }

  @override
  Future<List<NutritionPlan>> getMemberNutritionPlans(String memberId) async {
    return _plans.where((plan) => plan.memberId == memberId).toList();
  }

  @override
  Future<NutritionPlan?> getNutritionPlanById(String id) async {
    try {
      return _plans.firstWhere((plan) => plan.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> createNutritionPlan(NutritionPlan plan) async {
    _plans.add(plan);
  }

  @override
  Future<void> updateNutritionPlan(NutritionPlan plan) async {
    final index = _plans.indexWhere((p) => p.id == plan.id);
    if (index >= 0) {
      _plans[index] = plan;
    }
  }

  @override
  Future<void> deleteNutritionPlan(String id) async {
    _plans.removeWhere((plan) => plan.id == id);
  }
}
