import 'package:dartz/dartz.dart';
import 'package:wildfit_coach/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../repositories/workout_repository.dart';

class DeleteWorkoutPlan extends UseCase<void, String> {
  final WorkoutRepository repository;

  DeleteWorkoutPlan(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteWorkoutPlan(id);
  }
}
