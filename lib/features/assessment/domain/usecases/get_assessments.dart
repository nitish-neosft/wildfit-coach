import '../entities/user_assessment.dart';
import '../repositories/assessment_repository.dart';

class GetAssessments {
  final AssessmentRepository repository;

  GetAssessments(this.repository);

  Future<List<UserAssessment>> call() async {
    return await repository.getAssessments();
  }
}
