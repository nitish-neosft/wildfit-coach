import 'package:flutter/material.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/rest_client.dart';
import '../models/session_model.dart';
import '../../domain/entities/session.dart';

abstract class SessionRemoteDataSource {
  Future<List<Session>> getTodaySessions();
  Future<Session> createSession(Session session);
  Future<void> updateSession(Session session);
  Future<void> deleteSession(String id);
  Future<void> completeSession(String id);
}

class SessionRemoteDataSourceImpl implements SessionRemoteDataSource {
  final RestClient client;

  SessionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Session>> getTodaySessions() async {
    try {
      // Mock data for demonstration
      return [
        SessionModel(
          id: '1',
          title: 'Morning Workout with John',
          notes: 'Focus on upper body strength training',
          date: DateTime.now(),
          time: const TimeOfDay(hour: 9, minute: 0),
          memberId: 'member1',
          memberName: 'John Smith',
          memberAvatar: 'https://i.pravatar.cc/150?img=1',
          type: 'workout',
          isCompleted: false,
        ),
        SessionModel(
          id: '2',
          title: 'Nutrition Consultation',
          notes: 'Review meal plan and progress',
          date: DateTime.now(),
          time: const TimeOfDay(hour: 11, minute: 30),
          memberId: 'member2',
          memberName: 'Sarah Johnson',
          memberAvatar: 'https://i.pravatar.cc/150?img=2',
          type: 'nutrition',
          isCompleted: false,
        ),
        SessionModel(
          id: '3',
          title: 'Evening HIIT Session',
          notes: 'High-intensity interval training',
          date: DateTime.now(),
          time: const TimeOfDay(hour: 16, minute: 0),
          memberId: 'member3',
          memberName: 'Mike Wilson',
          memberAvatar: 'https://i.pravatar.cc/150?img=3',
          type: 'workout',
          isCompleted: false,
        ),
        SessionModel(
          id: '4',
          title: 'Assessment Review',
          notes: 'Monthly progress assessment',
          date: DateTime.now(),
          time: const TimeOfDay(hour: 14, minute: 15),
          memberId: 'member4',
          memberName: 'Emma Davis',
          memberAvatar: 'https://i.pravatar.cc/150?img=4',
          type: 'assessment',
          isCompleted: true,
        ),
      ];
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Session> createSession(Session session) async {
    try {
      final model = SessionModel.fromEntity(session);
      final response = await client.createSession(model.toJson());
      return response.toEntity();
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateSession(Session session) async {
    try {
      final model = SessionModel.fromEntity(session);
      await client.updateSession(session.id, model.toJson());
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteSession(String id) async {
    try {
      await client.deleteSession(id);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> completeSession(String id) async {
    try {
      await client.completeSession(id);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
