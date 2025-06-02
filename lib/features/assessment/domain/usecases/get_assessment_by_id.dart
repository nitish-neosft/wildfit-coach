import '../entities/user_assessment.dart';
import '../repositories/assessment_repository.dart';

class GetAssessmentById {
  final AssessmentRepository repository;

  GetAssessmentById(this.repository);

  Future<UserAssessment?> call(String id) async {
    return await repository.getAssessmentById(id);
  }
}
