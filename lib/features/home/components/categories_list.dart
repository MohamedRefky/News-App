import 'package:flutter/material.dart';
import 'package:news_app/core/themes/light_color.dart';
import 'package:news_app/features/home/controller/home_controlle.dart';
import 'package:provider/provider.dart';

import 'viewall_component.dart';

class CategoriesList extends StatelessWidget {
  CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<HomeControlle>(
        builder: (BuildContext context, HomeControlle controller, Widget? child) {
          return Column(
            children: [
              ViewallComponent(
                title: 'Categories',
                titleColor: Color(0xFF141414),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 20, right: 16),
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
            ],
          );
        },
      ),
    );
  }
  final List<String> category = [
    'Technology',
    'General',
    'Sports',
    'Entertainment',
    'Business',
    'Health',
    'Science',
  ];
}
