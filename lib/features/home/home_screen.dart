import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/categories_list.dart';
import 'components/trinding_news.dart';
import 'components/viewall_component.dart';
import 'controller/home_controlle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
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
                CategoriesList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
