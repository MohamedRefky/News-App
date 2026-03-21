import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/home/cubit/home_state.dart';
import 'news_item.dart';
import 'top_headline_shimmer.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        switch (state.topHeadlineStatus) {
          case RequestStatusEnum.initial:
          case RequestStatusEnum.loading:
            return TopHeadlineShimmer();
          case RequestStatusEnum.error:
            return SliverToBoxAdapter(child: Center(child: Text(state.errorMessage ?? 'An error occurred')));
          case RequestStatusEnum.loaded:
            return SliverList.builder(
              itemCount: state.newsTopHeadlineList.length,
              itemBuilder: (context, index) {
                final model = state.newsTopHeadlineList[index];
                return NewsItem(model: model);
              },
            );
        }
      },
    );
  }
}
