import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/nutrition_repository.dart';

class DeleteNutritionPlan {
  final NutritionRepository repository;

  DeleteNutritionPlan(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteNutritionPlan(id);
  }
}
