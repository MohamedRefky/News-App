import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super( InitialOnboardingState());
  PageController pageController = PageController();
  void onPageChanged(int index) {
    if (index == 2) {
      emit(state.copyWith(currentIndex: index, isLastPage: true));
    } else {
      emit(state.copyWith(currentIndex: index, isLastPage: false));
    }
  }

  void nextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
