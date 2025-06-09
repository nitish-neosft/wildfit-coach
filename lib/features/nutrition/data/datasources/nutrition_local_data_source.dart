import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/nutrition_plan_model.dart';

abstract class NutritionLocalDataSource {
  Future<List<NutritionPlanModel>> getNutritionPlans();
  Future<NutritionPlanModel?> getNutritionPlanById(String id);
}

class NutritionLocalDataSourceImpl implements NutritionLocalDataSource {
  @override
  Future<List<NutritionPlanModel>> getNutritionPlans() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/data/nutrition_plans.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // Convert JSON to List of NutritionPlanModel objects
      final List<dynamic> nutritionPlansJson = jsonData['nutrition_plans'];
      return nutritionPlansJson
          .map((json) => NutritionPlanModel.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<NutritionPlanModel?> getNutritionPlanById(String id) async {
    try {
      final nutritionPlans = await getNutritionPlans();
      return nutritionPlans.firstWhere(
        (plan) => plan.id == id,
        orElse: () => throw Exception(),
      );
    } catch (e) {
      return null;
    }
  }
}
