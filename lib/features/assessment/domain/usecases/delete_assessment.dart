import '../repositories/assessment_repository.dart';

class DeleteAssessment {
  final AssessmentRepository repository;

  DeleteAssessment(this.repository);

  Future<void> call(String id) async {
    await repository.deleteAssessment(id);
  }
}
