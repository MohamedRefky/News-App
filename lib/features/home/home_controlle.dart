import 'package:flutter/material.dart';
import 'package:news_app/core/data/remote_data/api_config.dart';
import 'package:news_app/core/data/remote_data/api_servise.dart';
import 'models/news_article_model.dart';

class HomeControlle with ChangeNotifier {
  List<NewsArticleModel> newsTopHeadlineList = [];
  List<NewsArticleModel> newsTopEverythingList = [];
  ApiServise apiServise = ApiServise();
  bool topHeadlineLoading = true;
  bool everythingLoading = true;
  String? errorMessage;

  HomeControlle() {
    geTopHeadline();
    geTopEverything();
  }
  void geTopHeadline() async {
    try {
      Map<String, dynamic> result = await apiServise.get(
        ApiConfig.topHeadlines,
        params: {'country': 'us'},
      );

      newsTopHeadlineList = (result['articles'] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
      topHeadlineLoading = false;
      errorMessage = null;
    } catch (e) {
      topHeadlineLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void geTopEverything() async {
    try {
      Map<String, dynamic> result = await apiServise.get(
        ApiConfig.everything,
        params: {'q': 'bitcoin'},
      );

      newsTopEverythingList = (result['articles'] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
      everythingLoading = false;
      errorMessage = null;
    } catch (e) {
      everythingLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
