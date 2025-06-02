import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
  Future<UserModel> refreshToken();
  Future<bool> resetPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw UnauthorizedException(e.message ?? 'Invalid credentials');
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw BadRequestException(e.message ?? 'Registration failed');
    }
  }

  @override
  Future<UserModel> refreshToken() async {
    try {
      final response = await _dio.post(ApiEndpoints.refreshToken);
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw UnauthorizedException(e.message ?? 'Token refresh failed');
    }
  }

  @override
  Future<bool> resetPassword(String email) async {
    try {
      await _dio.post(
        ApiEndpoints.resetPassword,
        data: {'email': email},
      );
      return true;
    } on DioException {
      return false;
    }
  }
}
