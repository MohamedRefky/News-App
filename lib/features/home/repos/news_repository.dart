import 'package:news_app/core/data/remote_data/api_config.dart';
import 'package:news_app/core/data/remote_data/api_servise.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

abstract class BaseNewsRepository {
  Future<List<NewsArticleModel>> getTopHeadline({String? selectedCategory = 'General'});
  Future<List<NewsArticleModel>> geTopEverything();
}

class NewsRepository extends BaseNewsRepository {
  NewsRepository(this.apiServise);
  final BaseApiServise apiServise;

  @override
  Future<List<NewsArticleModel>> getTopHeadline({String? selectedCategory = 'General'}) async {
    Map<String, dynamic> result = await apiServise.get(
      ApiConfig.topHeadlines,
      params: {'country': 'us', 'category': selectedCategory},
    );
    return (result['articles'] as List).map((e) => NewsArticleModel.fromJson(e)).toList();
  }

  @override
  Future<List<NewsArticleModel>> geTopEverything() async {
    Map<String, dynamic> result = await apiServise.get(
      ApiConfig.everything,
      params: {'q': 'bitcoin'},
    );
    return (result['articles'] as List).map((e) => NewsArticleModel.fromJson(e)).toList();
  }
}
