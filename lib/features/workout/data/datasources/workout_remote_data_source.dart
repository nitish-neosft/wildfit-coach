import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/rest_client.dart';
import '../models/workout_plan_model.dart';

abstract class WorkoutRemoteDataSource {
  Future<List<WorkoutPlanModel>> getMemberWorkoutPlans(String memberId);
  Future<WorkoutPlanModel> getWorkoutPlan(String id);
  Future<WorkoutPlanModel> createWorkoutPlan(WorkoutPlanModel workoutPlan);
  Future<WorkoutPlanModel> updateWorkoutPlan(WorkoutPlanModel workoutPlan);
  Future<void> deleteWorkoutPlan(String id);
  Future<void> assignWorkoutPlan(String planId, String memberId);
  Future<void> unassignWorkoutPlan(String planId, String memberId);
  Future<void> updateWorkoutPlanProgress(String planId, double progress);
}

class WorkoutRemoteDataSourceImpl implements WorkoutRemoteDataSource {
  final RestClient client;

  WorkoutRemoteDataSourceImpl({
    required this.client,
  });

  Future<Map<String, dynamic>> _loadSampleData() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/workout_plans.json');
      return json.decode(jsonString);
    } catch (e) {
      throw ServerException('Failed to load workout plan data');
    }
  }

  @override
  Future<List<WorkoutPlanModel>> getMemberWorkoutPlans(String memberId) async {
    try {
      final jsonData = await _loadSampleData();
      final List<dynamic> plans = jsonData['workout_plans']
          .where((plan) => plan['member_id'] == memberId)
          .toList();
      return plans.map((json) => WorkoutPlanModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException('Failed to get member workout plans');
    }
  }

  @override
  Future<WorkoutPlanModel> getWorkoutPlan(String id) async {
    try {
      final jsonData = await _loadSampleData();
      final planJson = jsonData['workout_plans'].firstWhere(
        (plan) => plan['id'] == id,
        orElse: () => throw NotFoundException('Workout plan not found'),
      );
      return WorkoutPlanModel.fromJson(planJson);
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ServerException('Failed to get workout plan');
    }
  }

  @override
  Future<WorkoutPlanModel> createWorkoutPlan(
      WorkoutPlanModel workoutPlan) async {
    // For sample data, just return the plan as is
    return workoutPlan;
  }

  @override
  Future<WorkoutPlanModel> updateWorkoutPlan(
      WorkoutPlanModel workoutPlan) async {
    // For sample data, just return the updated plan
    return workoutPlan;
  }

  @override
  Future<void> deleteWorkoutPlan(String id) async {
    // No-op for sample data
  }

  @override
  Future<void> assignWorkoutPlan(String planId, String memberId) async {
    // No-op for sample data
  }

  @override
  Future<void> unassignWorkoutPlan(String planId, String memberId) async {
    // No-op for sample data
  }

  @override
  Future<void> updateWorkoutPlanProgress(String planId, double progress) async {
    // No-op for sample data
  }
}
