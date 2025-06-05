import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/nutrition_plan.dart';
import '../repositories/nutrition_repository.dart';

class DeleteMeal {
  final NutritionRepository repository;

  DeleteMeal(this.repository);

  Future<Either<Failure, NutritionPlan>> call({
    required String planId,
    required String mealId,
  }) async {
    return await repository.deleteMeal(planId, mealId);
  }
}
