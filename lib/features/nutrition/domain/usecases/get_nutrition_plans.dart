import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/nutrition_plan.dart';
import '../repositories/nutrition_repository.dart';

class GetNutritionPlans implements UseCase<List<NutritionPlan>, NoParams> {
  final NutritionRepository repository;

  GetNutritionPlans(this.repository);

  @override
  Future<Either<Failure, List<NutritionPlan>>> call(NoParams params) async {
    try {
      final plans = await repository.getNutritionPlans();
      return Right(plans);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
