import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/nutrition_plan_model.dart';

abstract class NutritionLocalDataSource {
  Future<NutritionPlanModel> getLastNutritionPlan(String id);
  Future<List<NutritionPlanModel>> getLastMemberNutritionPlans(String memberId);
  Future<void> cacheNutritionPlan(NutritionPlanModel nutritionPlanToCache);
  Future<void> cacheMemberNutritionPlans(
      String memberId, List<NutritionPlanModel> nutritionPlansToCache);
  Future<void> deleteNutritionPlan(String id);
}

const CACHED_NUTRITION_PLAN_PREFIX = 'CACHED_NUTRITION_PLAN_';
const CACHED_MEMBER_NUTRITION_PLANS_PREFIX = 'CACHED_MEMBER_NUTRITION_PLANS_';

class NutritionLocalDataSourceImpl implements NutritionLocalDataSource {
  final SharedPreferences sharedPreferences;

  NutritionLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<NutritionPlanModel> getLastNutritionPlan(String id) async {
    final jsonString =
        sharedPreferences.getString('$CACHED_NUTRITION_PLAN_PREFIX$id');
    if (jsonString != null) {
      return NutritionPlanModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException('No cached nutrition plan found');
    }
  }

  @override
  Future<List<NutritionPlanModel>> getLastMemberNutritionPlans(
      String memberId) async {
    final jsonString = sharedPreferences
        .getString('$CACHED_MEMBER_NUTRITION_PLANS_PREFIX$memberId');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => NutritionPlanModel.fromJson(json)).toList();
    } else {
      throw CacheException('No cached nutrition plans found');
    }
  }

  @override
  Future<void> cacheNutritionPlan(
      NutritionPlanModel nutritionPlanToCache) async {
    await sharedPreferences.setString(
      '$CACHED_NUTRITION_PLAN_PREFIX${nutritionPlanToCache.id}',
      json.encode(nutritionPlanToCache.toJson()),
    );
  }

  @override
  Future<void> cacheMemberNutritionPlans(
    String memberId,
    List<NutritionPlanModel> nutritionPlansToCache,
  ) async {
    final List<Map<String, dynamic>> jsonList =
        nutritionPlansToCache.map((plan) => plan.toJson()).toList();
    await sharedPreferences.setString(
      '$CACHED_MEMBER_NUTRITION_PLANS_PREFIX$memberId',
      json.encode(jsonList),
    );
  }

  @override
  Future<void> deleteNutritionPlan(String id) async {
    await sharedPreferences.remove('$CACHED_NUTRITION_PLAN_PREFIX$id');
  }
}
