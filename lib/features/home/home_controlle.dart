import 'package:flutter/material.dart';
import 'package:news_app/core/data/remote_data/api_config.dart';
import 'package:news_app/core/data/remote_data/api_servise.dart';
import 'package:news_app/core/enums/request_status_enums.dart';

import 'models/news_article_model.dart';

class HomeControlle with ChangeNotifier {
  List<NewsArticleModel> newsTopHeadlineList = [];
  List<NewsArticleModel> newsTopEverythingList = [];
  ApiServise apiServise = ApiServise();

  RequestStatusEnum everyThingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadlineStatus = RequestStatusEnum.loading;
  //bool topHeadlineLoading = true;

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
      topHeadlineStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
     topHeadlineStatus = RequestStatusEnum.error;
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
      everyThingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      everyThingStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
