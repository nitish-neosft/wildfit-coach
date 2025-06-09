import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:wildfit_coach/core/network/rest_client.dart';
import 'package:wildfit_coach/features/members/data/models/assessment_model.dart';
import '../models/member_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class MemberRemoteDataSource {
  Future<MemberModel> getMember(String id);
  Future<void> updateMember(MemberModel member);
  Future<void> addAssessment(String memberId, AssessmentModel assessment);
  Future<List<MemberModel>> getMembers();
  Future<void> updateMemberGoals({
    required String id,
    double? weightGoal,
    double? bodyFatGoal,
    int? weeklyWorkoutGoal,
  });
  Future<void> checkIn(String id);
  Future<void> updateMemberMeasurements(
      String id, Map<String, dynamic> measurements);
  Future<MemberModel> createMember(MemberModel member);
  Future<void> deleteMember(String id);
  Future<List<MemberModel>> getMembersWithPendingAssessments();
}

class MemberRemoteDataSourceImpl implements MemberRemoteDataSource {
  final RestClient _client;

  MemberRemoteDataSourceImpl(this._client);

  Future<Map<String, dynamic>> _loadSampleData() async {
    final String jsonString = await rootBundle.loadString(
        'lib/features/members/data/sample/pending_assessments.json');
    return json.decode(jsonString);
  }

  @override
  Future<MemberModel> getMember(String id) async {
    try {
      final jsonData = await _loadSampleData();
      final List<dynamic> members = jsonData['members'];
      final memberJson = members.firstWhere(
        (member) => member['id'] == id,
        orElse: () => throw NotFoundException('Member not found'),
      );
      return MemberModel.fromJson(memberJson);
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ServerException('Failed to get member details');
    }
  }

  @override
  Future<List<MemberModel>> getMembers() async {
    try {
      final jsonData = await _loadSampleData();
      final List<dynamic> members = jsonData['members'];
      return members.map((json) => MemberModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException('Failed to load members');
    }
  }

  @override
  Future<MemberModel> createMember(MemberModel member) async {
    // For sample data, just return the member as is
    return member;
  }

  @override
  Future<void> updateMember(MemberModel member) async {
    // No-op for sample data
  }

  @override
  Future<void> deleteMember(String id) async {
    // No-op for sample data
  }

  @override
  Future<void> addAssessment(
      String memberId, AssessmentModel assessment) async {
    // No-op for sample data
  }

  @override
  Future<void> checkIn(String id) async {
    // No-op for sample data
  }

  @override
  Future<void> updateMemberGoals({
    required String id,
    double? weightGoal,
    double? bodyFatGoal,
    int? weeklyWorkoutGoal,
  }) async {
    // No-op for sample data
  }

  @override
  Future<void> updateMemberMeasurements(
      String id, Map<String, dynamic> measurements) async {
    // No-op for sample data
  }

  @override
  Future<List<MemberModel>> getMembersWithPendingAssessments() async {
    try {
      final data = await _loadSampleData();
      final List<dynamic> membersJson = data['members'];
      return membersJson.map((json) => MemberModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException('Failed to load sample data: ${e.toString()}');
    }
  }
}
