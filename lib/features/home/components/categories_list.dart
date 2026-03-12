import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/themes/light_color.dart';
import 'package:news_app/features/home/categories_screen.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';
import 'viewall_component.dart';

class CategoriesList extends StatelessWidget {
  CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<HomeController>(
        builder: (BuildContext context, HomeController controller, Widget? child) {
          return Column(
            children: [
              ViewallComponent(
                title: 'Categories',
                titleColor: Color(0xFF141414),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider.value(
                        value: controller,
                        child: CategoriesScreen(),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: AppSizes.w16,
                  bottom: AppSizes.h16,
                  right: AppSizes.w16,
                ),
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
