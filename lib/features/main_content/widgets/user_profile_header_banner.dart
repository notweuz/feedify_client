import 'package:feedify/features/main_content/main_content.dart';
import 'package:feedify/repositories/user/models/user.dart';
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
    return Stack(
      children: <Widget>[
        Positioned.fill(
          bottom: 180,
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : (user.bannerUrl != null
                    ? Image.network(
                        user.bannerUrl!,
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
                    : const UserProfileHeaderNoBanner()),
        ),
      ],
    );
  }
}
