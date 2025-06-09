import 'package:dartz/dartz.dart';
import 'package:wildfit_coach/features/members/domain/entities/member.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/dashboard_data.dart';

import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DashboardRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DashboardData>> getDashboardData() async {
    if (await networkInfo.isConnected) {
      try {
        final dashboardData = await remoteDataSource.getDashboardData();
        return Right(dashboardData);
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
  Future<Either<Failure, Member>> getMemberDetails(String memberId) async {
    if (await networkInfo.isConnected) {
      try {
        final member = await remoteDataSource.getMemberDetails(memberId);
        return Right(member);
      } on UnauthorizedException catch (e) {
        return Left(UnauthorizedFailure(e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.message));
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
}
