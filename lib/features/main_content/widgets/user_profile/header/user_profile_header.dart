import 'package:feedify/features/main_content/widgets/widget.dart';
import 'package:feedify/repositories/user/models/user.dart';
import 'package:flutter/material.dart';

class UserProfileHeader extends StatefulWidget {
  final User user;
  final bool isLoading;

  const UserProfileHeader({
    super.key,
    required this.user,
    required this.isLoading,
  });

  @override
  State<UserProfileHeader> createState() => _UserProfileHeaderState();
}

class _UserProfileHeaderState extends State<UserProfileHeader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        UserProfileHeaderBanner(user: widget.user, isLoading: widget.isLoading),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  child: UserAvatarWrapper(
                    size: 90,
                    child: NetworkAssetLoadingWidget(
                      isLoading: widget.isLoading,
                      imagePath: widget.user.avatarUrl,
                      fallback: UserNoAvatarWidget(
                        username: widget.user.username,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                UserProfileHeaderNames(user: widget.user),
                const SizedBox(height: 5),
                UserProfileHeaderStats(user: widget.user),
                const SizedBox(height: 5),
                if (widget.user.description.isNotEmpty)
                  Text(
                    widget.user.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
