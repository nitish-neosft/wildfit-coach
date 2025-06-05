import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/nutrition_plan.dart';
import '../repositories/nutrition_repository.dart';

class GetMemberNutritionPlans {
  final NutritionRepository repository;

  GetMemberNutritionPlans(this.repository);

  Future<Either<Failure, List<NutritionPlan>>> call(String memberId) async {
    return await repository.getMemberNutritionPlans(memberId);
  }
}
