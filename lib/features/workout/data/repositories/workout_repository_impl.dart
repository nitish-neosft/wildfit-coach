import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/workout_plan.dart';
import '../../domain/repositories/workout_repository.dart';
import '../datasources/workout_remote_data_source.dart';
import '../models/workout_plan_model.dart';
import '../datasources/workout_local_data_source.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final WorkoutLocalDataSource localDataSource;

  WorkoutRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<WorkoutPlan>>> getMemberWorkoutPlans(
      String memberId) async {
    if (await networkInfo.isConnected) {
      try {
        final workoutPlans =
            await remoteDataSource.getMemberWorkoutPlans(memberId);
        return Right(workoutPlans.map((model) => model.toEntity()).toList());
      } on UnauthorizedException catch (e) {
        return Left(UnauthorizedFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure('An unexpected error occurred'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, WorkoutPlan>> getWorkoutPlan(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final workoutPlan = await remoteDataSource.getWorkoutPlan(id);
        return Right(workoutPlan.toEntity());
      } on UnauthorizedException catch (e) {
        return Left(UnauthorizedFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure('An unexpected error occurred'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, WorkoutPlan>> createWorkoutPlan(
      WorkoutPlan workoutPlan) async {
    if (await networkInfo.isConnected) {
      try {
        final workoutPlanModel = WorkoutPlanModel.fromEntity(workoutPlan);
        final createdPlan =
            await remoteDataSource.createWorkoutPlan(workoutPlanModel);
        return Right(createdPlan.toEntity());
      } on UnauthorizedException catch (e) {
        return Left(UnauthorizedFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure('An unexpected error occurred'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, WorkoutPlan>> updateWorkoutPlan(
      WorkoutPlan workoutPlan) async {
    if (await networkInfo.isConnected) {
      try {
        final workoutPlanModel = WorkoutPlanModel.fromEntity(workoutPlan);
        final updatedPlan =
            await remoteDataSource.updateWorkoutPlan(workoutPlanModel);
        return Right(updatedPlan.toEntity());
      } on UnauthorizedException catch (e) {
        return Left(UnauthorizedFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure('An unexpected error occurred'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteWorkoutPlan(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteWorkoutPlan(id);
        return const Right(null);
      } on UnauthorizedException catch (e) {
        return Left(UnauthorizedFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure('An unexpected error occurred'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> assignWorkoutPlan(
      String planId, String memberId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.assignWorkoutPlan(planId, memberId);
        return const Right(null);
      } on UnauthorizedException catch (e) {
        return Left(UnauthorizedFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure('An unexpected error occurred'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> unassignWorkoutPlan(
      String planId, String memberId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.unassignWorkoutPlan(planId, memberId);
        return const Right(null);
      } on UnauthorizedException catch (e) {
        return Left(UnauthorizedFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure('An unexpected error occurred'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> updateWorkoutPlanProgress(
      String planId, double progress) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateWorkoutPlanProgress(planId, progress);
        return const Right(null);
      } on UnauthorizedException catch (e) {
        return Left(UnauthorizedFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure('An unexpected error occurred'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<WorkoutPlan>>> getWorkoutPlans() async {
    try {
      final workoutPlans = await localDataSource.getWorkoutPlans();
      return Right(workoutPlans.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(const CacheFailure());
    }
  }

  @override
  Future<Either<Failure, WorkoutPlan>> getWorkoutPlanById(String id) async {
    try {
      final workoutPlan = await localDataSource.getWorkoutPlanById(id);
      if (workoutPlan != null) {
        return Right(workoutPlan.toEntity());
      } else {
        return Left(const NotFoundFailure());
      }
    } catch (e) {
      return Left(const CacheFailure());
    }
  }
}
