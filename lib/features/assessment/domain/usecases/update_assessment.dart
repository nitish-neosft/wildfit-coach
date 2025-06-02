import '../entities/user_assessment.dart';
import '../repositories/assessment_repository.dart';

class UpdateAssessment {
  final AssessmentRepository repository;

  UpdateAssessment(this.repository);

  Future<void> call(UserAssessment assessment) async {
    await repository.updateAssessment(assessment);
  }
}
