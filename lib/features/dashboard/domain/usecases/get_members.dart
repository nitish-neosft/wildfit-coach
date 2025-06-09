import 'package:dartz/dartz.dart';

import 'package:wildfit_coach/core/error/failures.dart';

import '../../../../features/members/domain/entities/member.dart';
import '../repositories/dashboard_repository.dart';

class GetMembers {
  final DashboardRepository repository;

  GetMembers(this.repository);

  Future<Either<Failure, List<Member>>> call() async {
    return await repository.getMembers();
  }
}
