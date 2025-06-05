import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_assessment.dart';

abstract class AssessmentRepository {
  Future<Either<Failure, void>> saveAssessment(UserAssessment assessment);
  Future<Either<Failure, List<UserAssessment>>> getAssessments();
  Future<Either<Failure, UserAssessment?>> getAssessmentById(String id);
  Future<Either<Failure, void>> updateAssessment(UserAssessment assessment);
  Future<Either<Failure, void>> deleteAssessment(String id);
}
