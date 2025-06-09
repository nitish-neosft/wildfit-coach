import 'package:equatable/equatable.dart';
import 'food_item.dart';

class Meal extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<FoodItem> foods;
  final String scheduledTime; // Format: "HH:mm"
  final int calories;
  final Map<String, double> macros; // proteins, carbs, fats in grams
  final bool isCompleted;

  const Meal({
    required this.id,
    required this.name,
    required this.description,
    required this.foods,
    required this.scheduledTime,
    required this.calories,
    required this.macros,
    this.isCompleted = false,
  });

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

  Meal copyWith({
    String? id,
    String? name,
    String? description,
    List<FoodItem>? foods,
    String? scheduledTime,
    int? calories,
    Map<String, double>? macros,
    bool? isCompleted,
  }) {
    return Meal(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      foods: foods ?? this.foods,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      calories: calories ?? this.calories,
      macros: macros ?? this.macros,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
