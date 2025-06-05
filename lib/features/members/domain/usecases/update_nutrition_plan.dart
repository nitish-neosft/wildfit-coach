import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/nutrition_plan.dart';
import '../repositories/nutrition_repository.dart';

class UpdateNutritionPlan {
  final NutritionRepository repository;

  UpdateNutritionPlan(this.repository);

  Future<Either<Failure, NutritionPlan>> call(NutritionPlan plan) async {
    return await repository.updateNutritionPlan(plan);
  }
}
