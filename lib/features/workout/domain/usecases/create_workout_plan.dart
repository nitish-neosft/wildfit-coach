import 'package:dartz/dartz.dart';
import 'package:wildfit_coach/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/workout_plan.dart';
import '../repositories/workout_repository.dart';

class CreateWorkoutPlan extends UseCase<WorkoutPlan, WorkoutPlan> {
  final WorkoutRepository repository;

  CreateWorkoutPlan(this.repository);

  Future<Either<Failure, WorkoutPlan>> call(WorkoutPlan workoutPlan) async {
    return await repository.createWorkoutPlan(workoutPlan);
  }
}
