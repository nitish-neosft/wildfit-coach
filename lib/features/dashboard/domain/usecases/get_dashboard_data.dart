import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/dashboard_data.dart';
import '../repositories/dashboard_repository.dart';

class GetDashboardData {
  final DashboardRepository repository;

  GetDashboardData(this.repository);

  Future<Either<Failure, DashboardData>> call() {
    return repository.getDashboardData();
  }
}
