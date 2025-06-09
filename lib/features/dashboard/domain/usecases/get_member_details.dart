import 'package:dartz/dartz.dart';

import 'package:wildfit_coach/core/error/failures.dart';

import '../../../../features/members/domain/entities/member.dart';
import '../repositories/dashboard_repository.dart';

class GetMemberDetails {
  final DashboardRepository repository;

  GetMemberDetails(this.repository);

  Future<Either<Failure, Member>> call(String memberId) async {
    return await repository.getMemberDetails(memberId);
  }
}
