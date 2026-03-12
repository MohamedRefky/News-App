import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class TrindingNewsShimmer extends StatelessWidget {
  const TrindingNewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(left: AppSizes.w16),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => SizedBox(width: AppSizes.w12),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade300,
          child: Container(
            height: AppSizes.h140,
            width: AppSizes.w240,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(AppSizes.r12),
            ),
          ),
        );
      },
    );
  }
}
