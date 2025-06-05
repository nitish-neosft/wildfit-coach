import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  final String id;
  final String name;
  final String type;
  final int calories;
  final int protein;
  final int carbs;
  final int fats;
  final List<String> ingredients;
  final Map<String, dynamic>? instructions;

  const Meal({
    required this.id,
    required this.name,
    required this.type,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.ingredients,
    this.instructions,
  });

  Meal copyWith({
    String? id,
    String? name,
    String? type,
    int? calories,
    int? protein,
    int? carbs,
    int? fats,
    List<String>? ingredients,
    Map<String, dynamic>? instructions,
  }) {
    return Meal(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        calories,
        protein,
        carbs,
        fats,
        ingredients,
        instructions,
      ];
}
