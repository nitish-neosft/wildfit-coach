import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

/// Service class for handling user-related operations
class UserService {
  static const String _userKey = 'user_data';
  final SharedPreferences _prefs;

  UserService(this._prefs);

  /// Gets the current user from local storage
  Future<UserModel?> getUser() async {
    final userJson = _prefs.getString(_userKey);
    if (userJson != null) {
      return UserModel.fromJson(json.decode(userJson));
    }
    return null;
  }

  /// Saves the user to local storage
  Future<void> saveUser(UserModel user) async {
    await _prefs.setString(_userKey, json.encode(user.toJson()));
  }

  /// Removes the user from local storage
  Future<void> deleteUser() async {
    await _prefs.remove(_userKey);
  }

  /// Sends a password reset request for the given email
  Future<bool> resetPassword(String email) async {
    // TODO: Implement actual password reset logic
    // This is just a mock implementation
    return true;
  }

  /// Checks if a user is currently authenticated
  bool isAuthenticated() {
    final userJson = _prefs.getString(_userKey);
    return userJson != null;
  }
}
