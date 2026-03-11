import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({super.key, required this.imagePath, this.height, this.width});

  final String imagePath;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath,
      height: height ?? 80,
      width: width ?? 140,
      fit: BoxFit.cover,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade300,
        child: Container(height: height ?? 80, width: width ?? 140, color: Colors.grey.shade300),
      ),
      errorWidget: (context, url, error) =>
          Container(color: Colors.grey.shade300, child: const Icon(Icons.broken_image_outlined)),
    );
  }
}
