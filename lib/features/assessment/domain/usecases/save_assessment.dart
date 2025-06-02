import '../entities/user_assessment.dart';
import '../repositories/assessment_repository.dart';

class SaveAssessment {
  final AssessmentRepository repository;

  SaveAssessment(this.repository);

  Future<void> call(UserAssessment assessment) async {
    await repository.saveAssessment(assessment);
  }
}
