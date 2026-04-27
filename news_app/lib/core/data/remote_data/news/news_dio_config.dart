import 'package:dio/dio.dart';
import 'package:news_app/core/data/remote_data/interceptor/api_key_interceptor.dart';
import 'package:news_app/core/data/remote_data/interceptor/logging_interceptor.dart';
import 'package:news_app/core/data/remote_data/news/news_api_config.dart';

class NewsDioConfig {
  static Dio createDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: NewsApiConfig.newsBaseUrl,
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
        headers: {"accept": "application/json", "Content-Type": "application/json"},
      ),
    );
    dio.interceptors.addAll([ ApiKeyInterceptor(),LoggingInterceptor(),]);
    return dio;
  }
}
