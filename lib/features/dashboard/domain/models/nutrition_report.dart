class NutritionReport {
  final String id;
  final String memberId;
  final String nutritionistId;
  final DateTime date;
  final String title;
  final String description;
  final List<MealPlan> mealPlans;
  final Map<String, double> macroTargets;
  final List<String>? supplements;
  final String? notes;

  const NutritionReport({
    required this.id,
    required this.memberId,
    required this.nutritionistId,
    required this.date,
    required this.title,
    required this.description,
    required this.mealPlans,
    required this.macroTargets,
    this.supplements,
    this.notes,
  });

  factory NutritionReport.fromJson(Map<String, dynamic> json) {
    return NutritionReport(
      id: json['id'] as String,
      memberId: json['memberId'] as String,
      nutritionistId: json['nutritionistId'] as String,
      date: DateTime.parse(json['date'] as String),
      title: json['title'] as String,
      description: json['description'] as String,
      mealPlans: (json['mealPlans'] as List)
          .map((e) => MealPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
      macroTargets: Map<String, double>.from(json['macroTargets'] as Map),
      supplements: (json['supplements'] as List?)?.cast<String>(),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberId': memberId,
      'nutritionistId': nutritionistId,
      'date': date.toIso8601String(),
      'title': title,
      'description': description,
      'mealPlans': mealPlans.map((e) => e.toJson()).toList(),
      'macroTargets': macroTargets,
      'supplements': supplements,
      'notes': notes,
    };
  }
}

class MealPlan {
  final String name;
  final String time;
  final List<FoodItem> items;
  final double totalCalories;
  final Map<String, double> macros;

  const MealPlan({
    required this.name,
    required this.time,
    required this.items,
    required this.totalCalories,
    required this.macros,
  });

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    return MealPlan(
      name: json['name'] as String,
      time: json['time'] as String,
      items: (json['items'] as List)
          .map((e) => FoodItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCalories: json['totalCalories'] as double,
      macros: Map<String, double>.from(json['macros'] as Map),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'time': time,
      'items': items.map((e) => e.toJson()).toList(),
      'totalCalories': totalCalories,
      'macros': macros,
    };
  }
}

class FoodItem {
  final String name;
  final double quantity;
  final String unit;
  final double calories;
  final Map<String, double> macros;

  const FoodItem({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.calories,
    required this.macros,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      name: json['name'] as String,
      quantity: json['quantity'] as double,
      unit: json['unit'] as String,
      calories: json['calories'] as double,
      macros: Map<String, double>.from(json['macros'] as Map),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'calories': calories,
      'macros': macros,
    };
  }
}
