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
