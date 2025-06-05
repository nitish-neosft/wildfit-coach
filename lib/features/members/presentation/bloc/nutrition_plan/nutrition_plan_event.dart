import 'package:equatable/equatable.dart';
import '../../../domain/entities/nutrition_plan.dart';
import '../../../domain/entities/meal.dart';
import '../../../domain/entities/supplement.dart';

abstract class NutritionPlanEvent extends Equatable {
  const NutritionPlanEvent();

  @override
  List<Object?> get props => [];
}

class LoadNutritionPlan extends NutritionPlanEvent {
  final String planId;
  final String memberId;

  const LoadNutritionPlan({
    required this.planId,
    required this.memberId,
  });

  @override
  List<Object> get props => [planId, memberId];
}

class UpdateNutritionPlan extends NutritionPlanEvent {
  final NutritionPlan plan;

  const UpdateNutritionPlan({required this.plan});

  @override
  List<Object> get props => [plan];
}

class AddMeal extends NutritionPlanEvent {
  final String planId;
  final Meal meal;

  const AddMeal({
    required this.planId,
    required this.meal,
  });

  @override
  List<Object> get props => [planId, meal];
}

class UpdateMeal extends NutritionPlanEvent {
  final String planId;
  final Meal meal;

  const UpdateMeal({
    required this.planId,
    required this.meal,
  });

  @override
  List<Object> get props => [planId, meal];
}

class DeleteMeal extends NutritionPlanEvent {
  final String planId;
  final String mealId;

  const DeleteMeal({
    required this.planId,
    required this.mealId,
  });

  @override
  List<Object> get props => [planId, mealId];
}

class AddSupplement extends NutritionPlanEvent {
  final String planId;
  final Supplement supplement;

  const AddSupplement({
    required this.planId,
    required this.supplement,
  });

  @override
  List<Object> get props => [planId, supplement];
}

class DeleteSupplement extends NutritionPlanEvent {
  final String planId;
  final String supplementId;

  const DeleteSupplement({
    required this.planId,
    required this.supplementId,
  });

  @override
  List<Object> get props => [planId, supplementId];
}
