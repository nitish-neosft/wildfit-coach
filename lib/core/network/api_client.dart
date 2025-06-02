import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../error/exceptions.dart';
import 'api_endpoints.dart';

class ApiClient {
  late final Dio _dio;
  final FlutterSecureStorage _storage;

  ApiClient({
    Dio? dio,
    FlutterSecureStorage? storage,
  }) : _storage = storage ?? const FlutterSecureStorage() {
    _dio = dio ??
        Dio(BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          contentType: 'application/json',
          responseType: ResponseType.json,
        ));

    // Add logging interceptor in debug mode
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      compact: true,
    ));

    // Add auth interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          // Handle token refresh here if needed
        }
        return handler.next(error);
      },
    ));
  }

  Future<String?> _getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: requiresAuth ? null : {'Authorization': ''},
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw NetworkException('Failed to perform GET request: ${e.toString()}');
    }
  }

  Future<dynamic> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: requiresAuth ? null : {'Authorization': ''},
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw NetworkException('Failed to perform POST request: ${e.toString()}');
    }
  }

  Future<dynamic> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: requiresAuth ? null : {'Authorization': ''},
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw NetworkException('Failed to perform PUT request: ${e.toString()}');
    }
  }

  Future<dynamic> delete(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: requiresAuth ? null : {'Authorization': ''},
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw NetworkException(
          'Failed to perform DELETE request: ${e.toString()}');
    }
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException('Connection timed out');
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            return BadRequestException(
                error.response?.data?.toString() ?? 'Bad request');
          case 401:
            return UnauthorizedException(
                error.response?.data?.toString() ?? 'Unauthorized');
          case 403:
            return ForbiddenException(
                error.response?.data?.toString() ?? 'Forbidden');
          case 404:
            return NotFoundException(
                error.response?.data?.toString() ?? 'Not found');
          case 500:
            return ServerException(
                error.response?.data?.toString() ?? 'Server error');
          default:
            return NetworkException(
              'Request failed with status: ${error.response?.statusCode}',
            );
        }
      case DioExceptionType.cancel:
        return NetworkException('Request cancelled');
      case DioExceptionType.unknown:
        if (error.error != null) {
          return NetworkException(error.error.toString());
        }
        return NetworkException('Unknown error occurred');
      default:
        return NetworkException('Network error occurred');
    }
  }
}
