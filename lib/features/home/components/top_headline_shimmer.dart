import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class TopHeadlineShimmer extends StatelessWidget {
  const TopHeadlineShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.w16, vertical: AppSizes.h8),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade300,
            child: Container(
              height: AppSizes.h80,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(AppSizes.r12),
              ),
            ),
          ),
        );
      },
    );
  }
}
