import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/nutrition_plan.dart';
import '../entities/supplement.dart';
import '../repositories/nutrition_repository.dart';

class AddSupplement {
  final NutritionRepository repository;

  AddSupplement(this.repository);

  Future<Either<Failure, NutritionPlan>> call({
    required String planId,
    required Supplement supplement,
  }) async {
    return await repository.addSupplement(planId, supplement);
  }
}
