import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/nutrition_plan.dart';
import '../repositories/nutrition_repository.dart';

class GetNutritionPlanById implements UseCase<NutritionPlan, Params> {
  final NutritionRepository repository;

  GetNutritionPlanById(this.repository);

  @override
  Future<Either<Failure, NutritionPlan>> call(Params params) async {
    try {
      final plan = await repository.getNutritionPlanById(params.id);
      return Right(plan!);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class Params extends Equatable {
  final String id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}
