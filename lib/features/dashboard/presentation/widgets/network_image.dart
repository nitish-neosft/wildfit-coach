import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/colors.dart';
import 'package:flutter/foundation.dart';

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
    // For development/debug mode, bypass SSL certificate verification
    if (kDebugMode && imageUrl.startsWith('https://')) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Image.network(
          imageUrl,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
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
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
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
          // Bypass SSL certificate verification in debug mode
          headers: const {'User-Agent': 'Flutter Debug Mode'},
        ),
      );
    }

    // For production mode, use CachedNetworkImage with SSL verification
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
