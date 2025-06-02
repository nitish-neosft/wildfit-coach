import 'package:dartz/dartz.dart';

import 'package:wildfit_coach/core/error/failures.dart';

import '../entities/dashboard_member.dart';
import '../repositories/dashboard_repository.dart';

class GetMembers {
  final DashboardRepository repository;

  GetMembers(this.repository);

  Future<Either<Failure, List<DashboardMember>>> call() async {
    return await repository.getMembers();
  }
}
