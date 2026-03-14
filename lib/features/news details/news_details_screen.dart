import 'package:flutter/material.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.model});
  
  final NewsArticleModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('News Details')));
  }
}
