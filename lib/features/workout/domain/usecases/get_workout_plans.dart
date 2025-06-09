import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/workout_plan.dart';
import '../repositories/workout_repository.dart';

class GetWorkoutPlans implements UseCase<List<WorkoutPlan>, NoParams> {
  final WorkoutRepository repository;

  GetWorkoutPlans(this.repository);

  @override
  Future<Either<Failure, List<WorkoutPlan>>> call(NoParams params) async {
    return await repository.getWorkoutPlans();
  }
}
