import 'package:dio/dio.dart';
import 'news_dio_config.dart';

abstract class BaseNewsApiService {
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? params});
}

class NewsApiService extends BaseNewsApiService {
  final dio = NewsDioConfig.createDio();
  @override
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      final response = await dio.get(endpoint, queryParameters: params);

      return response.data as Map<String, dynamic>;
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
