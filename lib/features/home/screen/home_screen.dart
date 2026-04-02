import 'package:flutter/material.dart';

import '../components/categories_list.dart';
import '../components/top_headline.dart';
import '../components/trinding_news.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [TrindingNews(), CategoriesList(), TopHeadline()]),
    );
  }
}
