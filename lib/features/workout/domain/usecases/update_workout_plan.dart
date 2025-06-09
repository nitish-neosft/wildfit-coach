import 'package:dartz/dartz.dart';
import 'package:wildfit_coach/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/workout_plan.dart';
import '../repositories/workout_repository.dart';

class UpdateWorkoutPlan extends UseCase<WorkoutPlan, WorkoutPlan> {
  final WorkoutRepository repository;

  UpdateWorkoutPlan(this.repository);

  Future<Either<Failure, WorkoutPlan>> call(WorkoutPlan workoutPlan) async {
    return await repository.updateWorkoutPlan(workoutPlan);
  }
}
