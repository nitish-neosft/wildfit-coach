import 'package:dio/dio.dart';
import '../models/user_assessment_model.dart';

abstract class AssessmentRemoteDataSource {
  Future<void> saveAssessment(UserAssessmentModel assessment);
  Future<List<UserAssessmentModel>> getAssessments();
  Future<UserAssessmentModel?> getAssessmentById(String id);
  Future<void> updateAssessment(UserAssessmentModel assessment);
  Future<void> deleteAssessment(String id);
}

class AssessmentRemoteDataSourceImpl implements AssessmentRemoteDataSource {
  final Dio dio;

  AssessmentRemoteDataSourceImpl(this.dio);

  @override
  Future<void> saveAssessment(UserAssessmentModel assessment) async {
    try {
      await dio.post(
        '/assessments',
        data: assessment.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserAssessmentModel>> getAssessments() async {
    try {
      final response = await dio.get('/assessments');
      return (response.data as List)
          .map((json) => UserAssessmentModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserAssessmentModel?> getAssessmentById(String id) async {
    try {
      final response = await dio.get('/assessments/$id');
      return UserAssessmentModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateAssessment(UserAssessmentModel assessment) async {
    try {
      await dio.put(
        '/assessments/${assessment.id}',
        data: assessment.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAssessment(String id) async {
    try {
      await dio.delete('/assessments/$id');
    } catch (e) {
      rethrow;
    }
  }
}
