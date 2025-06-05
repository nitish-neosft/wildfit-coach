import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_assessment.dart';
import '../../domain/repositories/assessment_repository.dart';
import '../datasources/assessment_remote_data_source.dart';
import '../models/user_assessment_model.dart';

class AssessmentRepositoryImpl implements AssessmentRepository {
  final AssessmentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AssessmentRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<UserAssessment>>> getAssessments() async {
    if (await networkInfo.isConnected) {
      try {
        final assessmentModels = await remoteDataSource.getAssessments();
        return Right(
            assessmentModels.map((model) => model.toEntity()).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, UserAssessment?>> getAssessmentById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final assessmentModel = await remoteDataSource.getAssessmentById(id);
        return Right(assessmentModel?.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> saveAssessment(
      UserAssessment assessment) async {
    if (await networkInfo.isConnected) {
      try {
        final assessmentModel = UserAssessmentModel.fromEntity(assessment);
        await remoteDataSource.saveAssessment(assessmentModel);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> updateAssessment(
      UserAssessment assessment) async {
    if (await networkInfo.isConnected) {
      try {
        final assessmentModel = UserAssessmentModel.fromEntity(assessment);
        await remoteDataSource.updateAssessment(assessmentModel);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAssessment(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteAssessment(id);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}
