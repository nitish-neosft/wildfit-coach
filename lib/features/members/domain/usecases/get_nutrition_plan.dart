import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/nutrition_plan.dart';
import '../repositories/nutrition_repository.dart';

class GetNutritionPlan {
  final NutritionRepository repository;

  GetNutritionPlan(this.repository);

  Future<Either<Failure, NutritionPlan>> call(String id) async {
    return await repository.getNutritionPlan(id);
  }
}
