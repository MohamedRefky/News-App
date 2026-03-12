import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/themes/light_color.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: Consumer<HomeController>(
        builder: (BuildContext context, HomeController controller, Widget? child) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.w16, vertical: AppSizes.h15),
                child: SizedBox(
                  height: AppSizes.h35,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: category.length,
                    separatorBuilder: (context, index) => SizedBox(width: AppSizes.w12),
                    itemBuilder: (context, index) {
                      final isSelected = controller.selectedCategory == category[index];
                      return IntrinsicWidth(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.updateSelectCategory(category[index]);
                              },
                              child: Text(
                                category[index],
                                style: TextStyle(
                                  color: Color(0xFF363636),
                                  fontSize: AppSizes.sp16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            if (isSelected) ...[
                              SizedBox(height: AppSizes.h6),
                              Container(height: AppSizes.h2, color: LightColor.primaryColor),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.newsTopHeadlineList.length,
                  itemBuilder: (context, index) {
                    final model = controller.newsTopHeadlineList[index];
                    return NewsItem(model: model);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  final List<String> category = [
    'General',
    'Technology',
    'Sports',
    'Entertainment',
    'Business',
    'Health',
    'Science',
  ];
}
