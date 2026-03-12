import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/core/data/remote_data/api_config.dart';

class ApiServise {
  static final ApiServise _instance = ApiServise._();
  factory ApiServise() => _instance;
  ApiServise._();

  Future<dynamic> get(String endpoint, {Map<String, dynamic>? params}) async {
    var url = Uri.http(ApiConfig.baseUrl, 'v2/$endpoint', {'apiKey': ApiConfig.apiKey, ...?params});
    try {
      final http.Response response = await http.get(url);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception("Failed to load data");
    }
  }
}
