import 'package:flutter/material.dart';

class OnbordingController with ChangeNotifier {
  PageController pageController = PageController();
  int currentIndex = 0;
  bool isLastPage = false;

  void onPageChanged(int index) {
    currentIndex = index;
    
    if (currentIndex == 2) {
      isLastPage = true;
    } else {
      isLastPage = false;
    }

    notifyListeners();
  }

  void nextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
