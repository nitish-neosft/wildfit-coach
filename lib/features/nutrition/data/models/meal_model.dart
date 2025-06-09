import 'package:equatable/equatable.dart';
import '../../domain/entities/meal.dart';
import 'food_item_model.dart';

class MealModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<FoodItemModel> foods;
  final String scheduledTime;
  final int calories;
  final Map<String, double> macros;
  final bool isCompleted;

  const MealModel({
    required this.id,
    required this.name,
    required this.description,
    required this.foods,
    required this.scheduledTime,
    required this.calories,
    required this.macros,
    this.isCompleted = false,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      foods: (json['foods'] as List)
          .map((e) => FoodItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      scheduledTime: json['scheduled_time'] as String,
      calories: json['calories'] as int,
      macros: Map<String, double>.from(json['macros'] as Map),
      isCompleted: json['is_completed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'foods': foods.map((e) => e.toJson()).toList(),
      'scheduled_time': scheduledTime,
      'calories': calories,
      'macros': macros,
      'is_completed': isCompleted,
    };
  }

  factory MealModel.fromEntity(Meal entity) {
    return MealModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      foods:
          entity.foods.map((food) => FoodItemModel.fromEntity(food)).toList(),
      scheduledTime: entity.scheduledTime,
      calories: entity.calories,
      macros: Map<String, double>.from(entity.macros),
      isCompleted: entity.isCompleted,
    );
  }

  Meal toEntity() {
    return Meal(
      id: id,
      name: name,
      description: description,
      foods: foods.map((e) => e.toEntity()).toList(),
      scheduledTime: scheduledTime,
      calories: calories,
      macros: Map<String, double>.from(macros),
      isCompleted: isCompleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        foods,
        scheduledTime,
        calories,
        macros,
        isCompleted,
      ];
}
