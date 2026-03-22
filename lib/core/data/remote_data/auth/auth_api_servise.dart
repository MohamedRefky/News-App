import 'dart:convert';

import 'package:dio/dio.dart';

import 'auth_dio_config.dart';

abstract class BaseApiService {
  Future<dynamic> post(String endpoint, String baseUrl, {Map<String, dynamic>? body});
}

class AuthApiServise extends BaseApiService {
  final dio = AuthDioConfig.createDio();
  @override
  Future<dynamic> post(
    String endpoint,
    String baseUrl, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.post(endpoint, data: jsonEncode(body));

      final responseBody = response.data as Map<String, dynamic>;

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return responseBody;
      } else {
        throw Exception(responseBody["message"] ?? "Failed To load Data");
      }
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw Exception('Connection timeout - Please check your internet');
        case DioExceptionType.sendTimeout:
          throw Exception('Send timeout - Please try again');
        case DioExceptionType.receiveTimeout:
          throw Exception('Receive timeout - Server took too long to respond');
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          final data = e.response?.data;

          String message = 'Something went wrong';

          if (data is Map<String, dynamic>) {
            message = data['message'] ?? message;
          } else if (data is String) {
            message = 'Server returned invalid response';
          }
          throw Exception('Server error ($statusCode): $message');
        case DioExceptionType.cancel:
          throw Exception('Request was cancelled');
        case DioExceptionType.connectionError:
          throw Exception('No internet connection');
        default:
          throw Exception('Failed to load news');
      }
    }
  }
}
