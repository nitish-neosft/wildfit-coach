import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/nutrition_plan.dart';
import '../../domain/entities/meal.dart';
import '../../domain/entities/supplement.dart';
import '../../domain/repositories/nutrition_repository.dart';
import '../datasources/nutrition_remote_data_source.dart';
import '../datasources/nutrition_local_data_source.dart';
import '../models/nutrition_plan_model.dart';
import '../models/meal_model.dart';
import '../models/supplement_model.dart';

class NutritionRepositoryImpl implements NutritionRepository {
  final NutritionRemoteDataSource remoteDataSource;
  final NutritionLocalDataSource localDataSource;

  NutritionRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, NutritionPlan>> getNutritionPlan(String id) async {
    try {
      final remotePlan = await remoteDataSource.getNutritionPlan(id);
      await localDataSource.cacheNutritionPlan(remotePlan);
      return Right(remotePlan);
    } catch (e) {
      try {
        final localPlan = await localDataSource.getLastNutritionPlan(id);
        return Right(localPlan);
      } catch (e) {
        return Left(CacheFailure('Failed to get nutrition plan'));
      }
    }
  }

  @override
  Future<Either<Failure, List<NutritionPlan>>> getMemberNutritionPlans(
      String memberId) async {
    try {
      final remotePlans =
          await remoteDataSource.getMemberNutritionPlans(memberId);
      await localDataSource.cacheMemberNutritionPlans(memberId, remotePlans);
      return Right(remotePlans);
    } catch (e) {
      try {
        final localPlans =
            await localDataSource.getLastMemberNutritionPlans(memberId);
        return Right(localPlans);
      } catch (e) {
        return Left(CacheFailure('Failed to get member nutrition plans'));
      }
    }
  }

  @override
  Future<Either<Failure, NutritionPlan>> createNutritionPlan(
      NutritionPlan plan) async {
    try {
      final nutritionPlanModel = NutritionPlanModel.fromEntity(plan);
      final remotePlan =
          await remoteDataSource.createNutritionPlan(nutritionPlanModel);
      await localDataSource.cacheNutritionPlan(remotePlan);
      return Right(remotePlan);
    } catch (e) {
      return Left(ServerFailure('Failed to create nutrition plan'));
    }
  }

  @override
  Future<Either<Failure, NutritionPlan>> updateNutritionPlan(
      NutritionPlan plan) async {
    try {
      final nutritionPlanModel = NutritionPlanModel.fromEntity(plan);
      final remotePlan =
          await remoteDataSource.updateNutritionPlan(nutritionPlanModel);
      await localDataSource.cacheNutritionPlan(remotePlan);
      return Right(remotePlan);
    } catch (e) {
      return Left(ServerFailure('Failed to update nutrition plan'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNutritionPlan(String id) async {
    try {
      await remoteDataSource.deleteNutritionPlan(id);
      await localDataSource.deleteNutritionPlan(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to delete nutrition plan'));
    }
  }

  @override
  Future<Either<Failure, NutritionPlan>> addMeal(
      String planId, Meal meal) async {
    try {
      final mealModel = MealModel.fromEntity(meal);
      final remotePlan = await remoteDataSource.addMeal(planId, mealModel);
      await localDataSource.cacheNutritionPlan(remotePlan);
      return Right(remotePlan);
    } catch (e) {
      return Left(ServerFailure('Failed to add meal'));
    }
  }

  @override
  Future<Either<Failure, NutritionPlan>> updateMeal(
      String planId, Meal meal) async {
    try {
      final mealModel = MealModel.fromEntity(meal);
      final remotePlan = await remoteDataSource.updateMeal(planId, mealModel);
      await localDataSource.cacheNutritionPlan(remotePlan);
      return Right(remotePlan);
    } catch (e) {
      return Left(ServerFailure('Failed to update meal'));
    }
  }

  @override
  Future<Either<Failure, NutritionPlan>> deleteMeal(
      String planId, String mealId) async {
    try {
      final remotePlan = await remoteDataSource.deleteMeal(planId, mealId);
      await localDataSource.cacheNutritionPlan(remotePlan);
      return Right(remotePlan);
    } catch (e) {
      return Left(ServerFailure('Failed to delete meal'));
    }
  }

  @override
  Future<Either<Failure, NutritionPlan>> addSupplement(
      String planId, Supplement supplement) async {
    try {
      final supplementModel = SupplementModel.fromEntity(supplement);
      final remotePlan =
          await remoteDataSource.addSupplement(planId, supplementModel);
      await localDataSource.cacheNutritionPlan(remotePlan);
      return Right(remotePlan);
    } catch (e) {
      return Left(ServerFailure('Failed to add supplement'));
    }
  }

  @override
  Future<Either<Failure, NutritionPlan>> deleteSupplement(
      String planId, String supplementId) async {
    try {
      final remotePlan =
          await remoteDataSource.deleteSupplement(planId, supplementId);
      await localDataSource.cacheNutritionPlan(remotePlan);
      return Right(remotePlan);
    } catch (e) {
      return Left(ServerFailure('Failed to delete supplement'));
    }
  }
}
