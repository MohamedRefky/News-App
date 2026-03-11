import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/extension/date_time_extension.dart';
import 'package:news_app/core/themes/light_color.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                child: SizedBox(
                  height: 35,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: category.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 12),
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            if (isSelected) ...[
                              const SizedBox(height: 6),
                              Container(height: 2, color: LightColor.primaryColor),
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
                    return NewsItem(model:  model);
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
