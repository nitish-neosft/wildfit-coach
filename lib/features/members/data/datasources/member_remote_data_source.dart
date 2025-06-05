import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:wildfit_coach/features/members/domain/entities/assessment.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/rest_client.dart';
import '../../domain/entities/member.dart';
import '../models/member_model.dart';

abstract class MemberRemoteDataSource {
  Future<Member> getMember(String id);
  Future<void> updateMember(Member member);
  Future<void> addAssessment(String memberId, Assessment assessment);
  Future<List<Member>> getMembers();
  Future<Member> createMember(Member member);
  Future<void> deleteMember(String id);
  Future<void> updateMemberGoals({
    required String id,
    double? weightGoal,
    double? bodyFatGoal,
    int? weeklyWorkoutGoal,
  });
  Future<void> checkIn(String id);
  Future<void> updateMemberMeasurements(
      String id, Map<String, dynamic> measurements);
}

class MemberRemoteDataSourceImpl implements MemberRemoteDataSource {
  final RestClient _client;

  MemberRemoteDataSourceImpl(this._client);

  @override
  Future<Member> getMember(String id) async {
    try {
      // Load sample data from assets
      final jsonString =
          await rootBundle.loadString('assets/data/dashboard_data.json');
      final jsonData = json.decode(jsonString);
      final List<dynamic> membersJson = jsonData['members'];
      final memberJson = membersJson.firstWhere(
        (member) => member['id'] == id,
        orElse: () => throw NotFoundException('Member not found'),
      );

      return MemberModel(
        id: memberJson['id'],
        name: memberJson['name'],
        email: memberJson['email'],
        avatar: memberJson['avatar'],
        joinedAt: DateTime.parse(memberJson['joined_at']),
        plan: memberJson['plan'],
        hasWorkoutPlan: true,
        hasNutritionPlan: true,
        hasAssessment: true,
        trainerName: memberJson['trainer_name'],
        membershipExpiryDate: DateTime.parse(memberJson['membership_expiry']),
        lastCheckIn: DateTime.parse(memberJson['last_checkin']),
        daysPresent: memberJson['days_present'],
        height: (memberJson['height'] as num).toDouble(),
        weight: (memberJson['weight'] as num).toDouble(),
        bodyFat: (memberJson['body_fat'] as num).toDouble(),
        muscleMass: (memberJson['muscle_mass'] as num).toDouble(),
        bmi: (memberJson['bmi'] as num).toDouble(),
        weeklyWorkoutGoal: memberJson['weekly_workout_goal'],
        currentStreak: memberJson['streak_days'],
        activePrograms: 1,
        measurements: Map<String, dynamic>.from(memberJson['measurements']),
      );
    } on FormatException {
      throw ServerException('Invalid data format');
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ServerException('Failed to load member details');
    }
  }

  @override
  Future<void> updateMember(Member member) async {
    // TODO: Implement when backend is ready
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> addAssessment(String memberId, Assessment assessment) async {
    // TODO: Implement when backend is ready
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<List<Member>> getMembers() async {
    try {
      // Load sample data from assets
      final jsonString =
          await rootBundle.loadString('assets/data/dashboard_data.json');
      final jsonData = json.decode(jsonString);
      final List<dynamic> membersJson = jsonData['members'];

      return membersJson
          .map((memberJson) => MemberModel(
                id: memberJson['id'],
                name: memberJson['name'],
                email: memberJson['email'],
                avatar: memberJson['avatar'],
                joinedAt: DateTime.parse(memberJson['joined_at']),
                plan: memberJson['plan'],
                hasWorkoutPlan: true,
                hasNutritionPlan: true,
                hasAssessment: true,
                trainerName: memberJson['trainer_name'],
                membershipExpiryDate:
                    DateTime.parse(memberJson['membership_expiry']),
                lastCheckIn: DateTime.parse(memberJson['last_checkin']),
                daysPresent: memberJson['days_present'],
                height: (memberJson['height'] as num).toDouble(),
                weight: (memberJson['weight'] as num).toDouble(),
                bodyFat: (memberJson['body_fat'] as num).toDouble(),
                muscleMass: (memberJson['muscle_mass'] as num).toDouble(),
                bmi: (memberJson['bmi'] as num).toDouble(),
                weeklyWorkoutGoal: memberJson['weekly_workout_goal'],
                currentStreak: memberJson['streak_days'],
                activePrograms: 1,
                measurements:
                    Map<String, dynamic>.from(memberJson['measurements']),
              ))
          .toList();
    } catch (e) {
      throw ServerException('Failed to load members');
    }
  }

  @override
  Future<Member> createMember(Member member) async {
    // TODO: Implement when backend is ready
    await Future.delayed(const Duration(milliseconds: 500));
    return member;
  }

  @override
  Future<void> deleteMember(String id) async {
    // TODO: Implement when backend is ready
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> updateMemberGoals({
    required String id,
    double? weightGoal,
    double? bodyFatGoal,
    int? weeklyWorkoutGoal,
  }) async {
    // TODO: Implement when backend is ready
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> checkIn(String id) async {
    // TODO: Implement when backend is ready
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> updateMemberMeasurements(
      String id, Map<String, dynamic> measurements) async {
    // TODO: Implement when backend is ready
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
