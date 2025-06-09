import 'package:dartz/dartz.dart';
import 'package:wildfit_coach/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/workout_plan.dart';
import '../repositories/workout_repository.dart';

class GetMemberWorkoutPlans extends UseCase<List<WorkoutPlan>, String> {
  final WorkoutRepository repository;

  GetMemberWorkoutPlans(this.repository);

  @override
  Future<Either<Failure, List<WorkoutPlan>>> call(String memberId) async {
    return await repository.getMemberWorkoutPlans(memberId);
  }
}
