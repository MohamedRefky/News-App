import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/extension/date_time_extension.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.model});

  final NewsArticleModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Details')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.w16, vertical: AppSizes.h20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.r4),
                child: CustomCachedNetworkImage(
                  imagePath: model.urlToImage ?? '',
                  height: AppSizes.w215,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: AppSizes.h12),
              Text(
                model.title ?? '',
                style: TextStyle(
                  fontSize: AppSizes.sp20,
                  color: Color(0xFF141414),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: AppSizes.h8),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.r50),
                    child: Image.network(
                      model.urlToImage ?? '',
                      errorBuilder: (context, error, stackTrace) => const SizedBox(),
                      width: AppSizes.w28,
                      height: AppSizes.h28,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: AppSizes.w4),
                  Text(
                    (model.author ?? '').substring(
                      0,
                      min((model.author ?? '').length, 15),
                    ),
                    style: TextStyle(
                      fontSize: AppSizes.sp14,
                      color: Color(0xFF141414),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: AppSizes.w12),
                  Text(
                    model.publishedAt.formatDateTime(),
                    style: TextStyle(
                      fontSize: AppSizes.sp12,
                      color: Color(0xFF363636),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  CustomSvgPicture.withoutColor(
                    path: 'assets/images/bookmark_icon.svg',
                    width: AppSizes.w24,
                    height: AppSizes.h24,
                  ),
                ],
              ),
              SizedBox(height: AppSizes.h8),
              Text(
                model.description ?? '',
                style: TextStyle(
                  fontSize: AppSizes.sp14,
                  color: Color(0xFF363636),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
