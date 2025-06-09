import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/nutrition_plan.dart';
import '../repositories/nutrition_repository.dart';

class CreateNutritionPlan extends UseCase<void, NutritionPlan> {
  final NutritionRepository repository;

  CreateNutritionPlan(this.repository);

  @override
  Future<Either<Failure, void>> call(NutritionPlan nutritionPlan) async {
    try {
      await repository.createNutritionPlan(nutritionPlan);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
