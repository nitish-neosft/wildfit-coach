import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/nutrition_plan_model.dart';
import '../models/meal_model.dart';
import '../models/supplement_model.dart';

abstract class NutritionRemoteDataSource {
  Future<NutritionPlanModel> getNutritionPlan(String id);
  Future<List<NutritionPlanModel>> getMemberNutritionPlans(String memberId);
  Future<NutritionPlanModel> createNutritionPlan(NutritionPlanModel plan);
  Future<NutritionPlanModel> updateNutritionPlan(NutritionPlanModel plan);
  Future<void> deleteNutritionPlan(String id);
  Future<NutritionPlanModel> addMeal(String planId, MealModel meal);
  Future<NutritionPlanModel> updateMeal(String planId, MealModel meal);
  Future<NutritionPlanModel> deleteMeal(String planId, String mealId);
  Future<NutritionPlanModel> addSupplement(
      String planId, SupplementModel supplement);
  Future<NutritionPlanModel> deleteSupplement(
      String planId, String supplementId);
}

class NutritionRemoteDataSourceImpl implements NutritionRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  NutritionRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<NutritionPlanModel> getNutritionPlan(String id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/nutrition-plans/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return NutritionPlanModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException('Failed to get nutrition plan');
    }
  }

  @override
  Future<List<NutritionPlanModel>> getMemberNutritionPlans(
      String memberId) async {
    final response = await client.get(
      Uri.parse('$baseUrl/members/$memberId/nutrition-plans'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => NutritionPlanModel.fromJson(json)).toList();
    } else {
      throw ServerException('Failed to get member nutrition plans');
    }
  }

  @override
  Future<NutritionPlanModel> createNutritionPlan(
      NutritionPlanModel plan) async {
    final response = await client.post(
      Uri.parse('$baseUrl/nutrition-plans'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(plan.toJson()),
    );

    if (response.statusCode == 201) {
      return NutritionPlanModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException('Failed to create nutrition plan');
    }
  }

  @override
  Future<NutritionPlanModel> updateNutritionPlan(
      NutritionPlanModel plan) async {
    final response = await client.put(
      Uri.parse('$baseUrl/nutrition-plans/${plan.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(plan.toJson()),
    );

    if (response.statusCode == 200) {
      return NutritionPlanModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException('Failed to update nutrition plan');
    }
  }

  @override
  Future<void> deleteNutritionPlan(String id) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/nutrition-plans/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 204) {
      throw ServerException('Failed to delete nutrition plan');
    }
  }

  @override
  Future<NutritionPlanModel> addMeal(String planId, MealModel meal) async {
    final response = await client.post(
      Uri.parse('$baseUrl/nutrition-plans/$planId/meals'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(meal.toJson()),
    );

    if (response.statusCode == 200) {
      return NutritionPlanModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException('Failed to add meal');
    }
  }

  @override
  Future<NutritionPlanModel> updateMeal(String planId, MealModel meal) async {
    final response = await client.put(
      Uri.parse('$baseUrl/nutrition-plans/$planId/meals/${meal.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(meal.toJson()),
    );

    if (response.statusCode == 200) {
      return NutritionPlanModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException('Failed to update meal');
    }
  }

  @override
  Future<NutritionPlanModel> deleteMeal(String planId, String mealId) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/nutrition-plans/$planId/meals/$mealId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return NutritionPlanModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException('Failed to delete meal');
    }
  }

  @override
  Future<NutritionPlanModel> addSupplement(
      String planId, SupplementModel supplement) async {
    final response = await client.post(
      Uri.parse('$baseUrl/nutrition-plans/$planId/supplements'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(supplement.toJson()),
    );

    if (response.statusCode == 200) {
      return NutritionPlanModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException('Failed to add supplement');
    }
  }

  @override
  Future<NutritionPlanModel> deleteSupplement(
      String planId, String supplementId) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/nutrition-plans/$planId/supplements/$supplementId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return NutritionPlanModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException('Failed to delete supplement');
    }
  }
}
