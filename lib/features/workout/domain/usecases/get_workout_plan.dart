import 'package:dartz/dartz.dart';
import 'package:wildfit_coach/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/workout_plan.dart';
import '../repositories/workout_repository.dart';

class GetWorkoutPlan extends UseCase<WorkoutPlan, String> {
  final WorkoutRepository repository;

  GetWorkoutPlan(this.repository);

  Future<Either<Failure, WorkoutPlan>> call(String id) async {
    return await repository.getWorkoutPlanById(id);
  }
}
