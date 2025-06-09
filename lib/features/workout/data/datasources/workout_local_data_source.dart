import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/workout_plan_model.dart';

abstract class WorkoutLocalDataSource {
  Future<List<WorkoutPlanModel>> getWorkoutPlans();
  Future<WorkoutPlanModel?> getWorkoutPlanById(String id);
}

class WorkoutLocalDataSourceImpl implements WorkoutLocalDataSource {
  @override
  Future<List<WorkoutPlanModel>> getWorkoutPlans() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/data/workout_plans.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // Convert JSON to List of WorkoutPlanModel objects
      final List<dynamic> workoutPlansJson = jsonData['workout_plans'];
      return workoutPlansJson
          .map((json) => WorkoutPlanModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load workout plans: $e');
    }
  }

  @override
  Future<WorkoutPlanModel?> getWorkoutPlanById(String id) async {
    try {
      final workoutPlans = await getWorkoutPlans();
      return workoutPlans.firstWhere(
        (plan) => plan.id == id,
        orElse: () => throw Exception('Workout plan not found'),
      );
    } catch (e) {
      throw Exception('Failed to get workout plan: $e');
    }
  }
}
