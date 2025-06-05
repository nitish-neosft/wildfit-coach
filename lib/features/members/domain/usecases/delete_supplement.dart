import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/nutrition_plan.dart';
import '../repositories/nutrition_repository.dart';

class DeleteSupplement {
  final NutritionRepository repository;

  DeleteSupplement(this.repository);

  Future<Either<Failure, NutritionPlan>> call({
    required String planId,
    required String supplementId,
  }) async {
    return await repository.deleteSupplement(planId, supplementId);
  }
}
