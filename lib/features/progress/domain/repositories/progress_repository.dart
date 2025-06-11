import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/progress_report.dart';

abstract class ProgressRepository {
  Future<Either<Failure, ProgressReport>> getClientProgress(String memberId);
  Future<Either<Failure, List<ProgressReport>>> getAllClientsProgress();
}
