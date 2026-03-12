import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class SearchScreenController extends ChangeNotifier with SafeNotify {
  SearchScreenController(this.newsRepository);

  List<NewsArticleModel> newsTopEverythingList = [];
  String? errorMessage;
  RequestStatusEnum everyThingStatus = RequestStatusEnum.loading;
  final BaseNewsRepository newsRepository;
  TextEditingController searchController = TextEditingController();
  void geTopEverything() async {
    try {
      newsTopEverythingList = await newsRepository.geTopEverything(query: searchController.text);

      everyThingStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      everyThingStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }
}
