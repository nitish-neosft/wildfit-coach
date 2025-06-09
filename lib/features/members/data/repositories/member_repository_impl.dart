import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/member.dart';
import '../../domain/entities/assessment.dart';
import '../../domain/repositories/member_repository.dart';
import '../datasources/member_remote_data_source.dart';
import '../models/member_model.dart';
import '../models/assessment_model.dart' as assessment_model;

class MemberRepositoryImpl implements MemberRepository {
  final MemberRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MemberRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Member>>> getMembers() async {
    if (await networkInfo.isConnected) {
      try {
        final members = await remoteDataSource.getMembers();
        return Right(members);
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
  Future<Either<Failure, Member>> getMember(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMember = await remoteDataSource.getMember(id);
        return Right(remoteMember);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> updateMember(Member member) async {
    if (await networkInfo.isConnected) {
      try {
        final memberModel = MemberModel.fromEntity(member);
        await remoteDataSource.updateMember(memberModel);

        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> addAssessment(
    String memberId,
    Assessment assessment,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final assessmentModel = assessment_model.AssessmentModel(
          id: assessment.id,
          date: assessment.date,
          type: assessment.type,
          data: assessment.data,
        );
        await remoteDataSource.addAssessment(memberId, assessmentModel);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> updateMemberGoals({
    required String id,
    double? weightGoal,
    double? bodyFatGoal,
    int? weeklyWorkoutGoal,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateMemberGoals(
          id: id,
          weightGoal: weightGoal,
          bodyFatGoal: bodyFatGoal,
          weeklyWorkoutGoal: weeklyWorkoutGoal,
        );
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
  Future<Either<Failure, void>> checkIn(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.checkIn(id);
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
  Future<Either<Failure, void>> updateMemberMeasurements(
      String id, Map<String, dynamic> measurements) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateMemberMeasurements(id, measurements);
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
  Future<Either<Failure, Member>> createMember(Member member) async {
    if (await networkInfo.isConnected) {
      try {
        final memberModel = MemberModel.fromEntity(member);
        final createdMember = await remoteDataSource.createMember(memberModel);

        return Right(createdMember);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMember(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteMember(id);

        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Member>>>
      getMembersWithPendingAssessments() async {
    if (await networkInfo.isConnected) {
      try {
        final memberModels =
            await remoteDataSource.getMembersWithPendingAssessments();
        return Right(memberModels.map((model) => model.toEntity()).toList());
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
