import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:news_app/features/home/repos/news_repository.dart';

class HomeController with ChangeNotifier {
  List<NewsArticleModel> newsTopHeadlineList = [];
  List<NewsArticleModel> newsTopEverythingList = [];

  RequestStatusEnum everyThingStatus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadlineStatus = RequestStatusEnum.loading;

  String? errorMessage;
  String? selectedCategory;

  final BaseNewsRepository newsRepository ;

  HomeController(this.newsRepository) {
    geTopHeadline();
    geTopEverything();
  }
  void geTopHeadline({String? category}) async {
    try {
      topHeadlineStatus = RequestStatusEnum.loading;
      notifyListeners();
      newsTopHeadlineList = await newsRepository.getTopHeadline(selectedCategory: selectedCategory);

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
      newsTopEverythingList = await newsRepository.geTopEverything();

      everyThingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      everyThingStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void updateSelectCategory(String category) {
    selectedCategory = category;
    geTopHeadline(category: selectedCategory);
    notifyListeners();
  }
}
