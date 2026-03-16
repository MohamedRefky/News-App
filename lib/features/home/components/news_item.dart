import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/extension/date_time_extension.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:news_app/features/news%20details/news_details_screen.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});
  final NewsArticleModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return NewsDetailsScreen(model: model);
          },
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSizes.w16,
          right: AppSizes.w16,
          bottom: AppSizes.h12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.r8),
              child: CustomCachedNetworkImage(imagePath: model.urlToImage ?? ''),
            ),
            SizedBox(width: AppSizes.w8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.title ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.r50),
                        child: Image.network(
                          errorBuilder: (context, error, stackTrace) => const SizedBox(),
                          model.urlToImage ?? '',
                          width: AppSizes.w15,
                          height: AppSizes.h15,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: AppSizes.w3),
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
                                fontSize: AppSizes.sp12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: AppSizes.w8),
                            Expanded(
                              child: Text(
                                model.publishedAt.formatDateTime(),
                                style: TextStyle(
                                  color: Color(0xFF141414),
                                  fontSize: AppSizes.sp12,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            CustomSvgPicture.withoutColor(
                              path: 'assets/images/bookmark_icon.svg',
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
      ),
    );
  }
}
