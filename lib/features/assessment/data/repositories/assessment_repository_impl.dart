import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_assessment.dart';
import '../../domain/repositories/assessment_repository.dart';
import '../datasources/assessment_remote_data_source.dart';
import '../models/user_assessment_model.dart';

class AssessmentRepositoryImpl implements AssessmentRepository {
  final AssessmentRemoteDataSource remoteDataSource;

  AssessmentRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<UserAssessment>> getAssessments() async {
    try {
      final assessmentModels = await remoteDataSource.getAssessments();
      return assessmentModels.map((model) => model.toEntity()).toList();
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Server error');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserAssessment?> getAssessmentById(String id) async {
    try {
      final assessmentModel = await remoteDataSource.getAssessmentById(id);
      return assessmentModel?.toEntity();
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Server error');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> saveAssessment(UserAssessment assessment) async {
    try {
      final assessmentModel = UserAssessmentModel.fromEntity(assessment);
      await remoteDataSource.saveAssessment(assessmentModel);
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Server error');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateAssessment(UserAssessment assessment) async {
    try {
      final assessmentModel = UserAssessmentModel.fromEntity(assessment);
      await remoteDataSource.updateAssessment(assessmentModel);
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Server error');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteAssessment(String id) async {
    try {
      await remoteDataSource.deleteAssessment(id);
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Server error');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
