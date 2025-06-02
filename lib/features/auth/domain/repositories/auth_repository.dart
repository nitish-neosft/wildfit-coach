import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(String name, String email, String password);
  Future<void> logout();
  Future<User> refreshToken();
  Future<User?> getCurrentUser();
  Future<bool> resetPassword(String email);
}
