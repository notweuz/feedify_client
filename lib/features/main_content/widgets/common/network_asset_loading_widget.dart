import 'package:feedify/features/main_content/widgets/widget.dart';
import 'package:flutter/material.dart';

class NetworkAssetLoadingWidget extends StatelessWidget {
  final String? imagePath;
  final BoxFit? fit;
  final bool isLoading;
  final Widget? fallback;

  const NetworkAssetLoadingWidget({
    super.key,
    this.imagePath,
    this.fit,
    required this.isLoading,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : (imagePath != null
              ? Image.network(
                  imagePath!,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return CenteredCircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    );
                  },
                )
              : fallback!);
  }
}
