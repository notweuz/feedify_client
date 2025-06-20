import 'package:feedify/repositories/user/models/user.dart';
import 'package:flutter/material.dart';

class UserProfileHeaderNames extends StatelessWidget {
  final User user;

  const UserProfileHeaderNames({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.displayName!,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
        ),
        Text(
          "@${user.username}",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 18,
            color: Theme.of(
              context,
            ).textTheme.headlineSmall?.color?.withAlpha(175),
          ),
        ),
      ],
    );
  }
}
