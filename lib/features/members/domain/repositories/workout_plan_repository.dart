import '../entities/workout_plan.dart';

abstract class WorkoutPlanRepository {
  Future<List<WorkoutPlan>> getWorkoutPlans(String memberId);
  Future<WorkoutPlan> getWorkoutPlan(String planId);
  Future<WorkoutPlan> createWorkoutPlan(WorkoutPlan plan);
  Future<WorkoutPlan> updateWorkoutPlan(WorkoutPlan plan);
  Future<void> deleteWorkoutPlan(String planId);
  Future<void> assignWorkoutPlan(String memberId, String workoutPlanId);
  Future<void> unassignWorkoutPlan(String memberId, String workoutPlanId);
}
