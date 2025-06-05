import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/nutrition_plan.dart';
import '../entities/meal.dart';
import '../entities/supplement.dart';

abstract class NutritionRepository {
  Future<Either<Failure, NutritionPlan>> getNutritionPlan(String id);
  Future<Either<Failure, List<NutritionPlan>>> getMemberNutritionPlans(
      String memberId);
  Future<Either<Failure, NutritionPlan>> createNutritionPlan(
      NutritionPlan plan);
  Future<Either<Failure, NutritionPlan>> updateNutritionPlan(
      NutritionPlan plan);
  Future<Either<Failure, void>> deleteNutritionPlan(String id);

  Future<Either<Failure, NutritionPlan>> addMeal(String planId, Meal meal);
  Future<Either<Failure, NutritionPlan>> updateMeal(String planId, Meal meal);
  Future<Either<Failure, NutritionPlan>> deleteMeal(
      String planId, String mealId);

  Future<Either<Failure, NutritionPlan>> addSupplement(
      String planId, Supplement supplement);
  Future<Either<Failure, NutritionPlan>> deleteSupplement(
      String planId, String supplementId);
}
