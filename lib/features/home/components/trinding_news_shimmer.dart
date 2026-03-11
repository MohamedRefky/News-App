import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TrindingNewsShimmer extends StatelessWidget {
  const TrindingNewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 16),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => SizedBox(width: 12),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade300,
          child: Container(
            height: 140,
            width: 240,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}
