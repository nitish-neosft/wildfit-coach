import 'package:equatable/equatable.dart';
import '../../domain/entities/food_item.dart';

class FoodItemModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final double portion;
  final String unit;
  final int calories;
  final Map<String, double> nutrients;
  final String? category;
  final String? imageUrl;

  const FoodItemModel({
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

  factory FoodItemModel.fromJson(Map<String, dynamic> json) {
    return FoodItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      portion: (json['portion'] as num).toDouble(),
      unit: json['unit'] as String,
      calories: json['calories'] as int,
      nutrients: Map<String, double>.from(json['nutrients'] as Map),
      category: json['category'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'portion': portion,
      'unit': unit,
      'calories': calories,
      'nutrients': nutrients,
      'category': category,
      'image_url': imageUrl,
    };
  }

  factory FoodItemModel.fromEntity(FoodItem entity) {
    return FoodItemModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      portion: entity.portion,
      unit: entity.unit,
      calories: entity.calories,
      nutrients: Map<String, double>.from(entity.nutrients),
      category: entity.category,
      imageUrl: entity.imageUrl,
    );
  }

  FoodItem toEntity() {
    return FoodItem(
      id: id,
      name: name,
      description: description,
      portion: portion,
      unit: unit,
      calories: calories,
      nutrients: Map<String, double>.from(nutrients),
      category: category,
      imageUrl: imageUrl,
    );
  }

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
}
