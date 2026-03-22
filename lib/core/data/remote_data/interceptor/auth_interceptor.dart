import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/data/local_data/prefrances_maneger.dart';
import 'package:news_app/core/data/local_data/user_reposatory.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/main.dart';

class Authinterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? token = UserRepository().getUser()?.accessToken;
    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      final BuildContext context = navigatorKey.currentState!.context;
      UserRepository().delete();
      PreferencesManager().clear();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Session Expired, Please Login')));
    }
    handler.next(err);
  }
}
