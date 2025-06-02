import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/colors.dart';

class NetworkImageWithFallback extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final BoxFit? fit;

  const NetworkImageWithFallback({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.borderRadius,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.1),
            borderRadius: borderRadius,
          ),
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.primary,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.1),
            borderRadius: borderRadius,
          ),
          child: const Icon(
            Icons.person_outline,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
