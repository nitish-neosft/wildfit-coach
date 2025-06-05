import '../../../../core/network/rest_client.dart';
import '../models/user_assessment_model.dart';

abstract class AssessmentRemoteDataSource {
  Future<void> saveAssessment(UserAssessmentModel assessment);
  Future<List<UserAssessmentModel>> getAssessments();
  Future<UserAssessmentModel?> getAssessmentById(String id);
  Future<void> updateAssessment(UserAssessmentModel assessment);
  Future<void> deleteAssessment(String id);
}

class AssessmentRemoteDataSourceImpl implements AssessmentRemoteDataSource {
  final RestClient _client;

  AssessmentRemoteDataSourceImpl(this._client);

  @override
  Future<void> saveAssessment(UserAssessmentModel assessment) async {
    try {
      await _client.saveAssessment(assessment.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserAssessmentModel>> getAssessments() async {
    try {
      return await _client.getAssessments();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserAssessmentModel?> getAssessmentById(String id) async {
    try {
      return await _client.getAssessmentById(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateAssessment(UserAssessmentModel assessment) async {
    try {
      await _client.updateAssessment(assessment.id, assessment.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAssessment(String id) async {
    try {
      await _client.deleteAssessment(id);
    } catch (e) {
      rethrow;
    }
  }
}
