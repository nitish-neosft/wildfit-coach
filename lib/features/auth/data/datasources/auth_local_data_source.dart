import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<User?> getUser();
  Future<void> saveUser(User user);
  Future<void> deleteUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _userKey = 'user_data';
  final SharedPreferences _prefs;

  AuthLocalDataSourceImpl(this._prefs);

  @override
  Future<User?> getUser() async {
    final userJson = _prefs.getString(_userKey);
    if (userJson != null) {
      return UserModel.fromJson(json.decode(userJson));
    }
    return null;
  }

  @override
  Future<void> saveUser(User user) async {
    if (user is! UserModel) {
      throw Exception('User must be a UserModel');
    }
    await _prefs.setString(_userKey, json.encode(user.toJson()));
  }

  @override
  Future<void> deleteUser() async {
    await _prefs.remove(_userKey);
  }
}
