import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/extension/date_time_extension.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/home/controller/home_controlle.dart';
import 'package:provider/provider.dart';

import 'top_headline_shimmer.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeControlle>(
      builder: (BuildContext context, HomeControlle controller, Widget? child) {
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
                return Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CustomCachedNetworkImage(imagePath: model.urlToImage ?? ''),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(model.title ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CustomCachedNetworkImage(
                                    imagePath: model.urlToImage ?? '',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                SizedBox(width: 3),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        (model.author ?? '').substring(
                                          0,
                                          min((model.author ?? '').length, 10),
                                        ),
                                        style: TextStyle(
                                          color: Color(0xFF141414),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        model.publishedAt.formatDateTime(),
                                        style: TextStyle(
                                          color: Color(0xFF141414),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
        }
      },
    );
  }
}
