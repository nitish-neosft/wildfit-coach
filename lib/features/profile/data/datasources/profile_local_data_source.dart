import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/profile_settings_model.dart';

abstract class ProfileLocalDataSource {
  Future<ProfileSettingsModel> getProfileSettings();
  Future<void> updateNotificationSettings(NotificationSettingsModel settings);
  Future<void> updateLanguage(String language);
  Future<void> updatePassword(String currentPassword, String newPassword);
  Future<void> updateProfile({
    String? name,
    String? email,
    String? avatar,
  });
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  @override
  Future<ProfileSettingsModel> getProfileSettings() async {
    try {
      // Load the JSON file from assets
      final jsonString =
          await rootBundle.loadString('assets/data/profile_settings.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      // Add default values for new fields if they don't exist in the JSON
      jsonMap.putIfAbsent('role', () => 'coach');
      jsonMap.putIfAbsent('specialization', () => 'General Fitness');
      jsonMap.putIfAbsent('years_of_experience', () => 5);
      jsonMap.putIfAbsent(
          'certifications', () => ['CPT', 'Nutrition Specialist']);
      jsonMap.putIfAbsent('total_members', () => 50);
      jsonMap.putIfAbsent('active_members', () => 35);

      // Update notification settings structure
      final notifications = jsonMap['notifications'] as Map<String, dynamic>;
      notifications.putIfAbsent('member_check_in_alerts', () => true);
      notifications.putIfAbsent('member_assessment_reminders', () => true);
      notifications.putIfAbsent('member_progress_alerts', () => true);
      notifications.putIfAbsent('membership_expiry_alerts', () => true);
      notifications.putIfAbsent('new_member_assignments', () => true);
      notifications.putIfAbsent('staff_meeting_reminders', () => true);
      notifications.putIfAbsent('payment_reminders', () => true);

      return ProfileSettingsModel.fromJson(jsonMap);
    } catch (e) {
      throw Exception('Failed to load profile settings: $e');
    }
  }

  @override
  Future<void> updateNotificationSettings(
      NotificationSettingsModel settings) async {
    // In a real app, this would update local storage
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> updateLanguage(String language) async {
    // In a real app, this would update local storage
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    // In a real app, this would update local storage
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> updateProfile({
    String? name,
    String? email,
    String? avatar,
  }) async {
    // In a real app, this would update local storage
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
