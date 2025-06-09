import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/workout_plan.dart';
import '../repositories/workout_repository.dart';

class GetWorkoutPlanById implements UseCase<WorkoutPlan, Params> {
  final WorkoutRepository repository;

  GetWorkoutPlanById(this.repository);

  @override
  Future<Either<Failure, WorkoutPlan>> call(Params params) async {
    return await repository.getWorkoutPlanById(params.id);
  }
}

class Params extends Equatable {
  final String id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}
