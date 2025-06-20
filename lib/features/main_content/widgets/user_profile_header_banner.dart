import 'package:feedify/features/main_content/main_content.dart';
import 'package:feedify/repositories/user/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

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
              ? Shimmer(
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                  ),
                )
              : (user.bannerUrl != null
                  ? Image.network(
                      user.bannerUrl!,
                      fit: BoxFit.cover,
                    )
                  : const UserProfileHeaderNoBanner()),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 180,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
