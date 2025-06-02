import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../../../core/network/api_client.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/entities/dashboard_member.dart';
import '../models/dashboard_data_model.dart';
import '../models/dashboard_member_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardData> getDashboardData();
  Future<List<DashboardMember>> getMembers();
  Future<DashboardMember> getMemberDetails(String memberId);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiClient _apiClient;

  DashboardRemoteDataSourceImpl(this._apiClient);

  Future<Map<String, dynamic>> _loadJsonData() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/dashboard_data.json');
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw ServerException('Failed to load dashboard data: ${e.toString()}');
    }
  }

  @override
  Future<DashboardData> getDashboardData() async {
    try {
      final jsonData = await _loadJsonData();
      final model = DashboardDataModel.fromJson(jsonData);
      return model.toEntity();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to parse dashboard data: ${e.toString()}');
    }
  }

  @override
  Future<List<DashboardMember>> getMembers() async {
    try {
      final jsonData = await _loadJsonData();
      final List<dynamic> membersJson = jsonData['members'] as List<dynamic>;
      return membersJson
          .map((json) => DashboardMemberModel.fromJson(json).toEntity())
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to parse members data: ${e.toString()}');
    }
  }

  @override
  Future<DashboardMember> getMemberDetails(String memberId) async {
    try {
      final jsonData = await _loadJsonData();
      final List<dynamic> membersJson = jsonData['members'] as List<dynamic>;
      final memberJson = membersJson.firstWhere(
        (member) => member['id'] == memberId,
        orElse: () => throw ServerException('Member not found'),
      );
      return DashboardMemberModel.fromJson(memberJson).toEntity();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to fetch member details: ${e.toString()}');
    }
  }
}
