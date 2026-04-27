import 'package:equatable/equatable.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class SearchState extends Equatable {
  const SearchState({
    this.newsTopEverythingList = const [],
    this.everyThingStatus = RequestStatusEnum.loading,
    this.errorMessage,
  });
  final List<NewsArticleModel> newsTopEverythingList;
  final String? errorMessage;
  final RequestStatusEnum everyThingStatus;
  SearchState copyWith({
    List<NewsArticleModel>? newsTopEverythingList,
    String? errorMessage,
    RequestStatusEnum? everyThingStatus,
  }) {
    return SearchState(
      newsTopEverythingList: newsTopEverythingList ?? this.newsTopEverythingList,
      everyThingStatus: everyThingStatus ?? this.everyThingStatus,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [newsTopEverythingList, everyThingStatus, errorMessage];
}

final class SearchInitial extends SearchState {}
