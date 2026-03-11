import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

import 'news_item.dart';
import 'top_headline_shimmer.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller, Widget? child) {
        switch (controller.topHeadlineStatus) {
          case RequestStatusEnum.loading:
            return TopHeadlineShimmer();
          case RequestStatusEnum.error:
            return SliverToBoxAdapter(child: Center(child: Text(controller.errorMessage!)));
          case RequestStatusEnum.loaded:
            return SliverList.builder(
              itemCount: controller.newsTopHeadlineList.length,
              itemBuilder: (context, index) {
                final model = controller.newsTopHeadlineList[index];
                return NewsItem(model: model);
              },
            );
        }
      },
    );
  }
}
