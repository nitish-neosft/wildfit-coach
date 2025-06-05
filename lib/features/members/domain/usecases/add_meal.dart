import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/nutrition_plan.dart';
import '../entities/meal.dart';
import '../repositories/nutrition_repository.dart';

class AddMeal {
  final NutritionRepository repository;

  AddMeal(this.repository);

  Future<Either<Failure, NutritionPlan>> call({
    required String planId,
    required Meal meal,
  }) async {
    return await repository.addMeal(planId, meal);
  }
}
