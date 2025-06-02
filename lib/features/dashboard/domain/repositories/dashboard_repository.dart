import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/dashboard_data.dart';
import '../entities/dashboard_member.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardData>> getDashboardData();
  Future<Either<Failure, List<DashboardMember>>> getMembers();
  Future<Either<Failure, DashboardMember>> getMemberDetails(String memberId);
}
