import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../features/members/domain/entities/member.dart';
import '../entities/dashboard_data.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardData>> getDashboardData();
  Future<Either<Failure, List<Member>>> getMembers();
  Future<Either<Failure, Member>> getMemberDetails(String memberId);
}
