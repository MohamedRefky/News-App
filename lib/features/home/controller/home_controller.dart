import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:news_app/core/repos/news_repository.dart';

class HomeController extends ChangeNotifier with SafeNotify {
  List<NewsArticleModel> newsTopHeadlineList = [];
  List<NewsArticleModel> newsTopEverythingList = [];

  RequestStatusEnum everyThingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadlineStatus = RequestStatusEnum.loading;

  String? errorMessage;
  String? selectedCategory;

  final BaseNewsRepository newsRepository;

  HomeController(this.newsRepository) {
    geTopHeadline();
    geTopEverything();
  }
  void geTopHeadline({String? category}) async {
    try {
      topHeadlineStatus = RequestStatusEnum.loading;
      safeNotify();
      newsTopHeadlineList = await newsRepository.getTopHeadline(selectedCategory: selectedCategory);

      topHeadlineStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      topHeadlineStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }

  void geTopEverything() async {
    try {
      newsTopEverythingList = await newsRepository.geTopEverything();

      everyThingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      everyThingStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }

  void updateSelectCategory(String category) {
    selectedCategory = category;
    geTopHeadline(category: selectedCategory);
    safeNotify();
  }


}
