import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/nutrition_repository.dart';

class DeleteNutritionPlan extends UseCase<void, String> {
  final NutritionRepository repository;

  DeleteNutritionPlan(this.repository);

  @override
  Future<Either<Failure, void>> call(String planId) async {
    try {
      await repository.deleteNutritionPlan(planId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
