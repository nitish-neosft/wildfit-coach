import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/meal.dart';

part 'meal_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MealModel extends Meal {
  const MealModel({
    required String id,
    required String name,
    required String type,
    required int calories,
    required int protein,
    required int carbs,
    required int fats,
    required List<String> ingredients,
    Map<String, dynamic>? instructions,
  }) : super(
          id: id,
          name: name,
          type: type,
          calories: calories,
          protein: protein,
          carbs: carbs,
          fats: fats,
          ingredients: ingredients,
          instructions: instructions,
        );

  factory MealModel.fromJson(Map<String, dynamic> json) =>
      _$MealModelFromJson(json);

  factory MealModel.fromEntity(Meal entity) {
    return MealModel(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      calories: entity.calories,
      protein: entity.protein,
      carbs: entity.carbs,
      fats: entity.fats,
      ingredients: entity.ingredients,
      instructions: entity.instructions,
    );
  }

  Map<String, dynamic> toJson() => _$MealModelToJson(this);
}
