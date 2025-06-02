import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<User> login(String email, String password) async {
    // Fake login implementation
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    // Create a fake user
    final user = UserModel(
      id: '1',
      name: 'Test User',
      email: email,
      joinedAt: DateTime.now(),
    );

    // Save the fake user to local storage
    await localDataSource.saveUser(user);
    return user;
  }

  @override
  Future<User> register(String name, String email, String password) async {
    // Fake registration implementation
    await Future.delayed(const Duration(seconds: 1));

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    final user = UserModel(
      id: '1',
      name: name,
      email: email,
      joinedAt: DateTime.now(),
    );

    await localDataSource.saveUser(user);
    return user;
  }

  @override
  Future<void> logout() async {
    await localDataSource.deleteUser();
  }

  @override
  Future<User> refreshToken() async {
    final currentUser = await localDataSource.getUser();
    if (currentUser == null) {
      throw Exception('No user found');
    }

    final user = UserModel(
      id: currentUser.id,
      name: currentUser.name,
      email: currentUser.email,
      joinedAt: currentUser.joinedAt,
    );

    await localDataSource.saveUser(user);
    return user;
  }

  @override
  Future<User?> getCurrentUser() async {
    return await localDataSource.getUser();
  }

  @override
  Future<bool> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
