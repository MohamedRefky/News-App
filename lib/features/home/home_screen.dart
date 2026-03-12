import 'package:flutter/material.dart';
import 'package:news_app/core/data/remote_data/api_servise.dart';
import 'package:news_app/core/repos/news_repository.dart';
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
      create: (BuildContext context) => HomeController(NewsRepository(ApiServise())),
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
