import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/nutrition_plan.dart';
import '../entities/meal.dart';
import '../repositories/nutrition_repository.dart';

class UpdateMeal {
  final NutritionRepository repository;

  UpdateMeal(this.repository);

  Future<Either<Failure, NutritionPlan>> call({
    required String planId,
    required Meal meal,
  }) async {
    return await repository.updateMeal(planId, meal);
  }
}
