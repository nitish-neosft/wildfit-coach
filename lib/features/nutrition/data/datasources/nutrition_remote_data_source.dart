import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/rest_client.dart';
import '../models/nutrition_plan_model.dart';

abstract class NutritionRemoteDataSource {
  Future<List<NutritionPlanModel>> getNutritionPlans();
  Future<List<NutritionPlanModel>> getMemberNutritionPlans(String memberId);
  Future<NutritionPlanModel> getNutritionPlan(String id);
  Future<NutritionPlanModel> createNutritionPlan(
      NutritionPlanModel nutritionPlan);
  Future<NutritionPlanModel> updateNutritionPlan(
      NutritionPlanModel nutritionPlan);
  Future<void> deleteNutritionPlan(String id);
  Future<void> assignNutritionPlan(String planId, String memberId);
  Future<void> unassignNutritionPlan(String planId, String memberId);
}

class NutritionRemoteDataSourceImpl implements NutritionRemoteDataSource {
  final RestClient client;

  NutritionRemoteDataSourceImpl({
    required this.client,
  });

  Future<Map<String, dynamic>> _loadSampleData() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/nutrition_plans.json');
      return json.decode(jsonString);
    } catch (e) {
      throw ServerException('Failed to load nutrition plan data');
    }
  }

  @override
  Future<List<NutritionPlanModel>> getNutritionPlans() async {
    try {
      final jsonData = await _loadSampleData();
      final List<dynamic> plans = jsonData['nutrition_plans'];
      return plans.map((json) => NutritionPlanModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException('Failed to get nutrition plans');
    }
  }

  @override
  Future<List<NutritionPlanModel>> getMemberNutritionPlans(
      String memberId) async {
    try {
      final jsonData = await _loadSampleData();
      final List<dynamic> plans = jsonData['nutrition_plans']
          .where((plan) => plan['member_id'] == memberId)
          .toList();
      return plans.map((json) => NutritionPlanModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException('Failed to get member nutrition plans');
    }
  }

  @override
  Future<NutritionPlanModel> getNutritionPlan(String id) async {
    try {
      final jsonData = await _loadSampleData();
      final planJson = jsonData['nutrition_plans'].firstWhere(
        (plan) => plan['id'] == id,
        orElse: () => throw NotFoundException('Nutrition plan not found'),
      );
      return NutritionPlanModel.fromJson(planJson);
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ServerException('Failed to get nutrition plan');
    }
  }

  @override
  Future<NutritionPlanModel> createNutritionPlan(
      NutritionPlanModel nutritionPlan) async {
    try {
      // For sample data, just return the created plan
      // In a real implementation, this would make an API call
      return nutritionPlan;
    } catch (e) {
      throw ServerException('Failed to create nutrition plan');
    }
  }

  @override
  Future<NutritionPlanModel> updateNutritionPlan(
      NutritionPlanModel nutritionPlan) async {
    try {
      // For sample data, just return the updated plan
      // In a real implementation, this would make an API call
      return nutritionPlan;
    } catch (e) {
      throw ServerException('Failed to update nutrition plan');
    }
  }

  @override
  Future<void> deleteNutritionPlan(String id) async {
    try {
      // For sample data, just return
      // In a real implementation, this would make an API call
      return;
    } catch (e) {
      throw ServerException('Failed to delete nutrition plan');
    }
  }

  @override
  Future<void> assignNutritionPlan(String planId, String memberId) async {
    try {
      // For sample data, just return
      // In a real implementation, this would make an API call
      return;
    } catch (e) {
      throw ServerException('Failed to assign nutrition plan');
    }
  }

  @override
  Future<void> unassignNutritionPlan(String planId, String memberId) async {
    try {
      // For sample data, just return
      // In a real implementation, this would make an API call
      return;
    } catch (e) {
      throw ServerException('Failed to unassign nutrition plan');
    }
  }
}
