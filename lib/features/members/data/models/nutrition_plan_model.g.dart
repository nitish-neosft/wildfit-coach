// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NutritionPlanModel _$NutritionPlanModelFromJson(Map<String, dynamic> json) =>
    NutritionPlanModel(
      id: json['id'] as String,
      memberId: json['member_id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      dailyCalories: (json['daily_calories'] as num).toInt(),
      mealsPerDay: (json['meals_per_day'] as num).toInt(),
      durationWeeks: (json['duration_weeks'] as num).toInt(),
      currentProtein: (json['current_protein'] as num).toInt(),
      targetProtein: (json['target_protein'] as num).toInt(),
      currentCarbs: (json['current_carbs'] as num).toInt(),
      targetCarbs: (json['target_carbs'] as num).toInt(),
      currentFats: (json['current_fats'] as num).toInt(),
      targetFats: (json['target_fats'] as num).toInt(),
      meals: (json['meals'] as List<dynamic>)
          .map((e) => MealModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      supplements: (json['supplements'] as List<dynamic>)
          .map((e) => SupplementModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NutritionPlanModelToJson(NutritionPlanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'member_id': instance.memberId,
      'name': instance.name,
      'type': instance.type,
      'daily_calories': instance.dailyCalories,
      'meals_per_day': instance.mealsPerDay,
      'duration_weeks': instance.durationWeeks,
      'current_protein': instance.currentProtein,
      'target_protein': instance.targetProtein,
      'current_carbs': instance.currentCarbs,
      'target_carbs': instance.targetCarbs,
      'current_fats': instance.currentFats,
      'target_fats': instance.targetFats,
      'meals': instance.meals.map((e) => e.toJson()).toList(),
      'supplements': instance.supplements.map((e) => e.toJson()).toList(),
    };
