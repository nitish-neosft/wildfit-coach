import '../../../../core/error/exceptions.dart';
import '../../../../core/network/rest_client.dart';
import '../models/profile_settings_model.dart';

abstract class ProfileRemoteDataSource {
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

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final RestClient _client;

  ProfileRemoteDataSourceImpl({required RestClient client}) : _client = client;

  @override
  Future<ProfileSettingsModel> getProfileSettings() async {
    try {
      return await _client.getProfileSettings();
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateNotificationSettings(
      NotificationSettingsModel settings) async {
    try {
      await _client.updateNotificationSettings(settings.toJson());
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateLanguage(String language) async {
    try {
      await _client.updateLanguage({'language': language});
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    try {
      await _client.updatePassword({
        'current_password': currentPassword,
        'new_password': newPassword,
      });
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateProfile({
    String? name,
    String? email,
    String? avatar,
  }) async {
    try {
      final data = {
        if (name != null) 'name': name,
        if (email != null) 'email': email,
        if (avatar != null) 'avatar': avatar,
      };
      await _client.updateProfile(data);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
