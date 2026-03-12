import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/extension/date_time_extension.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

import 'trinding_news_shimmer.dart';
import 'viewall_component.dart';

class TrindingNews extends StatelessWidget {
  const TrindingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: AppSizes.h280,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: AppSizes.h240,
              width: double.infinity,
              child: Image.asset('assets/images/background.png', fit: BoxFit.cover),
            ),
            Positioned.fill(
              top: AppSizes.h45,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/NEWEST.png',
                    height: AppSizes.h50,
                    width: AppSizes.w125,
                    fit: BoxFit.contain,
                  ),
                  ViewallComponent(title: 'Trending News', onTap: () {}),
                  Expanded(
                    child: Consumer<HomeController>(
                      builder: (BuildContext context, HomeController controller, Widget? child) {
                        switch (controller.everyThingStatus) {
                          case RequestStatusEnum.loading:
                            return TrindingNewsShimmer();
                          case RequestStatusEnum.error:
                            return Center(child: Text(controller.errorMessage!));
                          case RequestStatusEnum.loaded:
                            return ListView.separated(
                              padding: EdgeInsets.only(left: AppSizes.w16),
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) => SizedBox(width: AppSizes.w12),
                              itemCount: controller.newsTopEverythingList.take(7).length,
                              itemBuilder: (context, index) {
                                final model = controller.newsTopEverythingList[index];
                                return SizedBox(
                                  width: AppSizes.w240,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(AppSizes.r12),
                                    child: Stack(
                                      children: [
                                        if (model.urlToImage != null)
                                          CustomCachedNetworkImage(
                                            imagePath: model.urlToImage ?? '',
                                            width: AppSizes.w240,
                                            height: AppSizes.h140,
                                          ),
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.black.withValues(alpha: 0.3),
                                                  Colors.black.withValues(alpha: 0.7),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: AppSizes.h60,
                                          left: AppSizes.w12,
                                          right: AppSizes.w12,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                model.title!,
                                                style: TextStyle(
                                                  color: Color(0xFFFFFCFC),
                                                  fontSize: AppSizes.sp14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: AppSizes.h6),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(AppSizes.r50),
                                                          child: CustomCachedNetworkImage(
                                                            imagePath: model.urlToImage ?? '',
                                                            width: AppSizes.w20,
                                                            height: AppSizes.h20,
                                                          ),
                                                        ),
                                                        SizedBox(width: AppSizes.w6),
                                                        Expanded(
                                                          child: Text(
                                                            model.author ?? '',
                                                            style: TextStyle(
                                                              color: Color(0xFFFFFCFC),
                                                              fontSize: AppSizes.sp12,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    model.publishedAt.formatDateTime(),
                                                    style: TextStyle(
                                                      color: Color(0xFFFFFCFC),
                                                      fontSize: AppSizes.sp14,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
