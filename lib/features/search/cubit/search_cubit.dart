import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/repos/news_repository.dart' show BaseNewsRepository;
import 'package:news_app/features/search/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit( this.newsRepository) : super(SearchState());
  final BaseNewsRepository newsRepository;
  TextEditingController searchController = TextEditingController();

  void geTopEverything() async {
    try {
      emit(
        state.copyWith(
          everyThingStatus: RequestStatusEnum.loaded,
          errorMessage: null,
          newsTopEverythingList: await newsRepository.geTopEverything(
            query: searchController.text,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          everyThingStatus: RequestStatusEnum.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
