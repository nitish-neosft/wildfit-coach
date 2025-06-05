import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../error/exceptions.dart';
import 'api_endpoints.dart';

class DioConfig {
  static Dio createDio({
    required FlutterSecureStorage storage,
    String? baseUrl,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        contentType: 'application/json',
        responseType: ResponseType.json,
      ),
    );

    // Add logging interceptor
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      compact: true,
    ));

    // Add auth interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.read(key: 'auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // Handle token refresh here
            try {
              final refreshToken = await storage.read(key: 'refresh_token');
              if (refreshToken != null) {
                // Create a new Dio instance for refresh token request
                final refreshDio = Dio(dio.options);
                final response = await refreshDio.post(
                  ApiEndpoints.refreshToken,
                  data: {'refresh_token': refreshToken},
                );

                if (response.statusCode == 200) {
                  final newToken = response.data['token'];
                  await storage.write(key: 'auth_token', value: newToken);

                  // Retry the original request with new token
                  error.requestOptions.headers['Authorization'] =
                      'Bearer $newToken';
                  final clonedRequest = await dio.request(
                    error.requestOptions.path,
                    data: error.requestOptions.data,
                    queryParameters: error.requestOptions.queryParameters,
                    options: Options(
                      method: error.requestOptions.method,
                      headers: error.requestOptions.headers,
                    ),
                  );
                  return handler.resolve(clonedRequest);
                }
              }
            } catch (e) {
              // Token refresh failed
              await storage.deleteAll();
              return handler.next(error);
            }
          }
          return handler.next(error);
        },
      ),
    );

    // Add error handling interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          switch (error.type) {
            case DioExceptionType.connectionTimeout:
            case DioExceptionType.sendTimeout:
            case DioExceptionType.receiveTimeout:
              throw NetworkException('Connection timed out');
            case DioExceptionType.badResponse:
              final statusCode = error.response?.statusCode;
              final message =
                  error.response?.data?.toString() ?? 'Unknown error';

              switch (statusCode) {
                case 400:
                  throw BadRequestException(message);
                case 401:
                  throw UnauthorizedException(message);
                case 403:
                  throw ForbiddenException(message);
                case 404:
                  throw NotFoundException(message);
                case 500:
                  throw ServerException(message);
                default:
                  if (statusCode != null && statusCode >= 400) {
                    throw NetworkException(
                        'Request failed with status: $statusCode - $message');
                  }
                  return handler.next(error);
              }
            case DioExceptionType.cancel:
              throw NetworkException('Request cancelled');
            case DioExceptionType.unknown:
              if (error.error != null) {
                print('Unknown error details: ${error.error}');
                throw NetworkException(error.error.toString());
              }
              return handler.next(error);
            default:
              return handler.next(error);
          }
        },
      ),
    );

    return dio;
  }
}
