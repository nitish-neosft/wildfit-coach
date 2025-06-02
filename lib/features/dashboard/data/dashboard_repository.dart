import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../domain/models/dashboard_data.dart';

class DashboardRepository {
  final ApiClient _apiClient;

  DashboardRepository({required ApiClient client}) : _apiClient = client;

  Future<DashboardData> getDashboardData() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.dashboard);
      return DashboardData.fromJson(response);
    } catch (e) {
      // Fallback to local data during development
      final String jsonString =
          await rootBundle.loadString('assets/data/dashboard_data.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return DashboardData.fromJson(jsonMap);
    }
  }

  Future<List<DashboardMember>> getMembers() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.members);
      return (response as List)
          .map((json) => DashboardMember.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<DashboardMember> getMemberDetails(String memberId) async {
    try {
      final response =
          await _apiClient.get('${ApiEndpoints.memberDetails}$memberId');
      return DashboardMember.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
