import 'package:flutter/material.dart';

class NutritionPlan {
  final String id;
  final String memberId;
  final String name;
  final String type;
  final int dailyCalories;
  final int mealsPerDay;
  final int durationWeeks;
  final double currentProtein;
  final double targetProtein;
  final double currentCarbs;
  final double targetCarbs;
  final double currentFats;
  final double targetFats;
  final List<Meal> meals;
  final List<Supplement> supplements;

  NutritionPlan({
    required this.id,
    required this.memberId,
    required this.name,
    required this.type,
    required this.dailyCalories,
    required this.mealsPerDay,
    required this.durationWeeks,
    required this.currentProtein,
    required this.targetProtein,
    required this.currentCarbs,
    required this.targetCarbs,
    required this.currentFats,
    required this.targetFats,
    required this.meals,
    required this.supplements,
  });

  NutritionPlan copyWith({
    String? id,
    String? memberId,
    String? name,
    String? type,
    int? dailyCalories,
    int? mealsPerDay,
    int? durationWeeks,
    double? currentProtein,
    double? targetProtein,
    double? currentCarbs,
    double? targetCarbs,
    double? currentFats,
    double? targetFats,
    List<Meal>? meals,
    List<Supplement>? supplements,
  }) {
    return NutritionPlan(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      name: name ?? this.name,
      type: type ?? this.type,
      dailyCalories: dailyCalories ?? this.dailyCalories,
      mealsPerDay: mealsPerDay ?? this.mealsPerDay,
      durationWeeks: durationWeeks ?? this.durationWeeks,
      currentProtein: currentProtein ?? this.currentProtein,
      targetProtein: targetProtein ?? this.targetProtein,
      currentCarbs: currentCarbs ?? this.currentCarbs,
      targetCarbs: targetCarbs ?? this.targetCarbs,
      currentFats: currentFats ?? this.currentFats,
      targetFats: targetFats ?? this.targetFats,
      meals: meals ?? this.meals,
      supplements: supplements ?? this.supplements,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberId': memberId,
      'name': name,
      'type': type,
      'dailyCalories': dailyCalories,
      'mealsPerDay': mealsPerDay,
      'durationWeeks': durationWeeks,
      'currentProtein': currentProtein,
      'targetProtein': targetProtein,
      'currentCarbs': currentCarbs,
      'targetCarbs': targetCarbs,
      'currentFats': currentFats,
      'targetFats': targetFats,
      'meals': meals.map((meal) => meal.toJson()).toList(),
      'supplements':
          supplements.map((supplement) => supplement.toJson()).toList(),
    };
  }

  factory NutritionPlan.fromJson(Map<String, dynamic> json) {
    return NutritionPlan(
      id: json['id'] as String,
      memberId: json['memberId'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      dailyCalories: json['dailyCalories'] as int,
      mealsPerDay: json['mealsPerDay'] as int,
      durationWeeks: json['durationWeeks'] as int,
      currentProtein: json['currentProtein'] as double,
      targetProtein: json['targetProtein'] as double,
      currentCarbs: json['currentCarbs'] as double,
      targetCarbs: json['targetCarbs'] as double,
      currentFats: json['currentFats'] as double,
      targetFats: json['targetFats'] as double,
      meals: (json['meals'] as List<dynamic>)
          .map((meal) => Meal.fromJson(meal as Map<String, dynamic>))
          .toList(),
      supplements: (json['supplements'] as List<dynamic>)
          .map((supplement) =>
              Supplement.fromJson(supplement as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Meal {
  final String id;
  final String name;
  final TimeOfDay time;
  final int calories;
  final List<String> foods;

  Meal({
    required this.id,
    required this.name,
    required this.time,
    required this.calories,
    required this.foods,
  });

  Meal copyWith({
    String? id,
    String? name,
    TimeOfDay? time,
    int? calories,
    List<String>? foods,
  }) {
    return Meal(
      id: id ?? this.id,
      name: name ?? this.name,
      time: time ?? this.time,
      calories: calories ?? this.calories,
      foods: foods ?? this.foods,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'time': '${time.hour}:${time.minute}',
      'calories': calories,
      'foods': foods,
    };
  }

  factory Meal.fromJson(Map<String, dynamic> json) {
    final timeParts = (json['time'] as String).split(':');
    return Meal(
      id: json['id'] as String,
      name: json['name'] as String,
      time: TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      ),
      calories: json['calories'] as int,
      foods: (json['foods'] as List<dynamic>).cast<String>(),
    );
  }
}

class Supplement {
  final String id;
  final String name;
  final String dosage;
  final String timing;

  Supplement({
    required this.id,
    required this.name,
    required this.dosage,
    required this.timing,
  });

  Supplement copyWith({
    String? id,
    String? name,
    String? dosage,
    String? timing,
  }) {
    return Supplement(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      timing: timing ?? this.timing,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'timing': timing,
    };
  }

  factory Supplement.fromJson(Map<String, dynamic> json) {
    return Supplement(
      id: json['id'] as String,
      name: json['name'] as String,
      dosage: json['dosage'] as String,
      timing: json['timing'] as String,
    );
  }
}
