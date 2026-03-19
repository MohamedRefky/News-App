import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/data/remote_data/api_servise.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';

import 'components/categories_list.dart';
import 'components/top_headline.dart';
import 'components/trinding_news.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeCubit(NewsRepository(ApiServise()));
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [TrindingNews(), CategoriesList(), TopHeadline()],
        ),
      ),
    );
  }
}
