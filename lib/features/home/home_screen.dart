import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/categories_list.dart';
import 'components/top_headline.dart';
import 'components/trinding_news.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) => HomeController(),
      child: Consumer<HomeController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Scaffold(
            body: CustomScrollView(slivers: [TrindingNews(), CategoriesList(), TopHeadline()]),
          );
        },
      ),
    );
  }
}
