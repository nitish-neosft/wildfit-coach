import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_assessment.dart';
import '../repositories/assessment_repository.dart';

class GetAssessments implements UseCase<List<UserAssessment>, NoParams> {
  final AssessmentRepository repository;

  GetAssessments(this.repository);

  @override
  Future<Either<Failure, List<UserAssessment>>> call(NoParams params) async {
    return await repository.getAssessments();
  }
}
