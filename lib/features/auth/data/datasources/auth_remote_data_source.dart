import '../../../../core/error/exceptions.dart';
import '../../../../core/network/rest_client.dart';
import '../models/user_model.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
  Future<UserModel> refreshToken();
  Future<bool> resetPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final RestClient _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      return await _client.login({
        'email': email,
        'password': password,
      });
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException('Invalid credentials');
      } else if (e.response?.statusCode == 400) {
        throw BadRequestException('Invalid email or password format');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw NetworkException('Connection timeout');
      } else {
        throw ServerException(e.message ?? 'Server error occurred');
      }
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    try {
      return await _client.register({
        'name': name,
        'email': email,
        'password': password,
      });
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw BadRequestException('Email already exists or invalid data');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw NetworkException('Connection timeout');
      } else {
        throw ServerException(e.message ?? 'Registration failed');
      }
    }
  }

  @override
  Future<UserModel> refreshToken() async {
    try {
      return await _client.refreshToken();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException('Token expired or invalid');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw NetworkException('Connection timeout');
      } else {
        throw ServerException(e.message ?? 'Token refresh failed');
      }
    }
  }

  @override
  Future<bool> resetPassword(String email) async {
    try {
      await _client.resetPassword({'email': email});
      return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw NotFoundException('Email not found');
      } else if (e.response?.statusCode == 400) {
        throw BadRequestException('Invalid email format');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw NetworkException('Connection timeout');
      } else {
        throw ServerException(e.message ?? 'Password reset failed');
      }
    }
  }
}
