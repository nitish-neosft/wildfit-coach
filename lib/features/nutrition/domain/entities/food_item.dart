import 'package:equatable/equatable.dart';

class FoodItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final double portion;
  final String unit; // e.g., "g", "ml", "oz", "piece"
  final int calories;
  final Map<String, double> nutrients; // proteins, carbs, fats, fiber, etc.
  final String? category; // e.g., "proteins", "vegetables", "fruits"
  final String? imageUrl;

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.portion,
    required this.unit,
    required this.calories,
    required this.nutrients,
    this.category,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        portion,
        unit,
        calories,
        nutrients,
        category,
        imageUrl,
      ];

  FoodItem copyWith({
    String? id,
    String? name,
    String? description,
    double? portion,
    String? unit,
    int? calories,
    Map<String, double>? nutrients,
    String? category,
    String? imageUrl,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      portion: portion ?? this.portion,
      unit: unit ?? this.unit,
      calories: calories ?? this.calories,
      nutrients: nutrients ?? this.nutrients,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
