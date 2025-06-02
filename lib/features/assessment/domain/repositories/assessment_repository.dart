import '../entities/user_assessment.dart';

abstract class AssessmentRepository {
  Future<void> saveAssessment(UserAssessment assessment);
  Future<List<UserAssessment>> getAssessments();
  Future<UserAssessment?> getAssessmentById(String id);
  Future<void> updateAssessment(UserAssessment assessment);
  Future<void> deleteAssessment(String id);
}
