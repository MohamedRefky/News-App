import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/data/local_data/prefrances_maneger.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/onboarding/model/onboarding_model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'controller/onbording_controller.dart';

class OnboardingSceen extends StatelessWidget {
  const OnboardingSceen({super.key});

  void _onFinish(BuildContext context) async {
    await PreferencesManager().setBool('onboarding_complete', true);
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnbordingController>(
      create: (context) => OnbordingController(),
      builder: (context, child) {
        return Builder(
          builder: (context) {
            final controller = context.read<OnbordingController>();
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFFf5f5f5),
                actions: [
                  Consumer<OnbordingController>(
                    builder:
                        (BuildContext context, OnbordingController value, Widget? child) {
                          return value.isLastPage
                              ? SizedBox()
                              : TextButton(
                                  onPressed: () {
                                    _onFinish(context);
                                  },
                                  child: Text(
                                    'Skip',
                                    style: TextStyle(fontSize: AppSizes.sp16),
                                  ),
                                );
                        },
                  ),
                ],
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w16,
                  vertical: AppSizes.h30,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: controller.pageController,
                        onPageChanged: controller.onPageChanged,
                        itemCount: OnboardingModel.onboardingList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final OnboardingModel model =
                              OnboardingModel.onboardingList[index];
                          return Column(
                            children: [
                              Image.asset(model.image, fit: BoxFit.fill),
                              SizedBox(height: AppSizes.h24),

                              Text(
                                model.title,
                                style: TextStyle(
                                  fontSize: AppSizes.sp20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff4E4B66),
                                ),
                              ),
                              SizedBox(height: AppSizes.h12),
                              Text(
                                model.description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: AppSizes.sp16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff4E4B66),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    Consumer<OnbordingController>(
                      builder:
                          (
                            BuildContext context,
                            OnbordingController value,
                            Widget? child,
                          ) {
                            return SmoothPageIndicator(
                              controller: value.pageController,
                              count: OnboardingModel.onboardingList.length,
                              effect: SwapEffect(activeDotColor: Color(0xFFC53030)),
                            );
                          },
                    ),
                    SizedBox(height: AppSizes.h112),
                    Consumer<OnbordingController>(
                      builder:
                          (
                            BuildContext context,
                            OnbordingController value,
                            Widget? child,
                          ) {
                            return ElevatedButton(
                              onPressed: () {
                                if (!value.isLastPage) {
                                  controller.nextPage();
                                  Duration(milliseconds: 300);
                                  Curves.easeInOut;
                                } else {
                                  _onFinish(context);
                                }
                              },
                              child: Text(value.isLastPage ? 'Get Started' : 'Next'),
                            );
                          },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
