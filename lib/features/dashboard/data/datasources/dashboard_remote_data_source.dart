import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/rest_client.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/entities/dashboard_member.dart';
import '../models/dashboard_data_model.dart';
import '../models/dashboard_member_model.dart';
import 'package:dio/dio.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardData> getDashboardData();
  Future<List<DashboardMember>> getMembers();
  Future<DashboardMember> getMemberDetails(String memberId);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final RestClient _client;

  DashboardRemoteDataSourceImpl(this._client);

  @override
  Future<DashboardData> getDashboardData() async {
    try {
      // Load sample data from assets
      final jsonString =
          await rootBundle.loadString('assets/data/dashboard_data.json');
      final jsonData = json.decode(jsonString);
      return DashboardDataModel.fromJson(jsonData).toEntity();
    } catch (e) {
      throw ServerException('Failed to load dashboard data');
    }
  }

  @override
  Future<List<DashboardMember>> getMembers() async {
    try {
      // Load sample data from assets
      final jsonString =
          await rootBundle.loadString('assets/data/dashboard_data.json');
      final jsonData = json.decode(jsonString);
      final List<dynamic> membersJson = jsonData['members'];
      return membersJson
          .map((json) => DashboardMemberModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      throw ServerException('Failed to load members');
    }
  }

  @override
  Future<DashboardMember> getMemberDetails(String memberId) async {
    try {
      // Load sample data from assets
      final jsonString =
          await rootBundle.loadString('assets/data/dashboard_data.json');
      final jsonData = json.decode(jsonString);
      final List<dynamic> membersJson = jsonData['members'];
      final memberJson = membersJson.firstWhere(
        (member) => member['id'] == memberId,
        orElse: () => throw ServerException('Member not found'),
      );
      return DashboardMemberModel.fromJson(memberJson).toEntity();
    } catch (e) {
      throw ServerException('Failed to load member details');
    }
  }
}
