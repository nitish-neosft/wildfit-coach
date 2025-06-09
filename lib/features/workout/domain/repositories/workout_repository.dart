import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/workout_plan.dart';

abstract class WorkoutRepository {
  Future<Either<Failure, List<WorkoutPlan>>> getWorkoutPlans();
  Future<Either<Failure, List<WorkoutPlan>>> getMemberWorkoutPlans(
      String memberId);
  Future<Either<Failure, WorkoutPlan>> getWorkoutPlanById(String id);
  Future<Either<Failure, WorkoutPlan>> createWorkoutPlan(
      WorkoutPlan workoutPlan);
  Future<Either<Failure, WorkoutPlan>> updateWorkoutPlan(
      WorkoutPlan workoutPlan);
  Future<Either<Failure, void>> deleteWorkoutPlan(String id);
  Future<Either<Failure, void>> assignWorkoutPlan(
      String planId, String memberId);
  Future<Either<Failure, void>> unassignWorkoutPlan(
      String planId, String memberId);
  Future<Either<Failure, void>> updateWorkoutPlanProgress(
      String planId, double progress);
}
