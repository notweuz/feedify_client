import 'package:feedify/repositories/user/models/user.dart';
import 'package:feedify/features/main_content/widgets/widget.dart';
import 'package:flutter/material.dart';

class UserAvatarWidget extends StatelessWidget {
  final User user;
  final double size;

  const UserAvatarWidget({
    super.key,
    required this.user,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: user.avatarUrl != null && user.avatarUrl!.isNotEmpty
            ? Image.network(
                user.avatarUrl!,
                fit: BoxFit.cover,
                width: size,
                height: size,
                errorBuilder: (context, error, stackTrace) {
                  return UserNoAvatarWidget(username: user.username, size: size);
                },
              )
            : UserNoAvatarWidget(username: user.username, size: size),
      ),
    );
  }
}