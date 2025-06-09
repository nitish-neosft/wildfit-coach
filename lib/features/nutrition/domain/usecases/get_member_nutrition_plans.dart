import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/nutrition_plan.dart';
import '../repositories/nutrition_repository.dart';

class GetMemberNutritionPlans extends UseCase<List<NutritionPlan>, String> {
  final NutritionRepository repository;

  GetMemberNutritionPlans(this.repository);

  @override
  Future<Either<Failure, List<NutritionPlan>>> call(String memberId) async {
    try {
      final plans = await repository.getMemberNutritionPlans(memberId);
      return Right(plans);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
