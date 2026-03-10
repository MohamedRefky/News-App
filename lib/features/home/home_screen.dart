import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/trinding_news.dart';
import 'components/viewall_component.dart';
import 'home_controlle.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeControlle>(
      create: (BuildContext context) => HomeControlle(),

      child: Consumer<HomeControlle>(
        builder: (BuildContext context, controller, Widget? child) {
          return Scaffold(
            body: Column(
              children: [
                TrindingNews(),
                ViewallComponent(title: 'Categories', titleColor: Color(0xFF141414), onTap: () {}),
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 24),
                  child: SizedBox(
                    height: 30,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: category.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        return Text(
                          category[index],
                          style: TextStyle(
                            color: Color(0xFF363636),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
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
