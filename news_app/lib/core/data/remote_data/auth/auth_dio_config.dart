import 'package:dio/dio.dart';
import 'package:news_app/core/data/remote_data/interceptor/auth_interceptor.dart';
import 'package:news_app/core/data/remote_data/interceptor/logging_interceptor.dart';

import 'auth_api_config.dart';

class AuthDioConfig {
  static Dio createDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: AuthApiConfig.authBaseUrl,
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
        headers: {"accept": "application/json", "Content-Type": "application/json"},
      ),
    );
    dio.interceptors.addAll([Authinterceptor(), LoggingInterceptor()]);
    return dio;
  }
}
