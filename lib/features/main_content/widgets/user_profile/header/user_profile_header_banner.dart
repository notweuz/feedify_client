import 'dart:io';
import 'package:feedify/features/main_content/main_content.dart';
import 'package:feedify/repositories/user/models/user.dart';
import 'package:feedify/features/main_content/widgets/widget.dart';
import 'package:flutter/material.dart';

class UserProfileHeaderBanner extends StatelessWidget {
  final User user;
  final bool isLoading;

  const UserProfileHeaderBanner({
    super.key,
    required this.user,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    double size = 150;
    if (Platform.isWindows) size = 130;

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: size,
          child: NetworkAssetLoadingWidget(
            isLoading: isLoading,
            fit: BoxFit.cover,
            imagePath: user.bannerUrl,
            fallback: const UserProfileHeaderNoBanner(),
          ),
        ),
      ],
    );
  }
}
