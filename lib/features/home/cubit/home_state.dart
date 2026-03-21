import 'package:equatable/equatable.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class HomeState extends Equatable {
  const HomeState({
    this.errorMessage,
    this.selectedCategory = 'General',
    this.newsTopHeadlineList = const [],
    this.newsTopEverythingList = const [],
    this.everyThingStatus = RequestStatusEnum.loading,
    this.topHeadlineStatus = RequestStatusEnum.loading,
  });

  final List<NewsArticleModel> newsTopHeadlineList;
  final List<NewsArticleModel> newsTopEverythingList;

  final RequestStatusEnum everyThingStatus;
  final RequestStatusEnum topHeadlineStatus;

  final String? errorMessage;
  final String? selectedCategory;

  HomeState copyWith({
    String? errorMessage,
    String? selectedCategory,
    List<NewsArticleModel>? newsTopHeadlineList,
    List<NewsArticleModel>? newsTopEverythingList,
    RequestStatusEnum? everyThingStatus,
    RequestStatusEnum? topHeadlineStatus,
  }) {
    return HomeState(
      errorMessage: errorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      newsTopHeadlineList: newsTopHeadlineList ?? this.newsTopHeadlineList,
      newsTopEverythingList: newsTopEverythingList ?? this.newsTopEverythingList,
      everyThingStatus: everyThingStatus ?? this.everyThingStatus,
      topHeadlineStatus: topHeadlineStatus ?? this.topHeadlineStatus,
    );
  }

  @override
  List<Object?> get props => [
    errorMessage,
    selectedCategory,
    newsTopHeadlineList,
    newsTopEverythingList,
    everyThingStatus,
    topHeadlineStatus,
  ];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}
