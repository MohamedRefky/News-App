import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/repos/news_repository.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.newsRepository) : super(const HomeInitial()) {
    getTopHeadline();
    getTopEverything();
  }
  final BaseNewsRepository newsRepository;
  void getTopHeadline({String? category}) async {
    try {
      emit(state.copyWith(topHeadlineStatus: RequestStatusEnum.loading));

      final articles = await newsRepository.getTopHeadline(
        selectedCategory: state.selectedCategory,
      );
      emit(
        state.copyWith(
          newsTopHeadlineList: articles,
          topHeadlineStatus: RequestStatusEnum.loaded,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          topHeadlineStatus: RequestStatusEnum.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void getTopEverything() async {
    try {
      final articles = await newsRepository.geTopEverything();
      emit(
        state.copyWith(
          newsTopEverythingList: articles,
          everyThingStatus: RequestStatusEnum.loaded,
          errorMessage: null,
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

  void updateSelectCategory(String category) {
    emit(state.copyWith(selectedCategory: category));

    getTopHeadline(category: state.selectedCategory);
  }
}
