import 'package:feedify/repositories/user/models/user.dart';
import 'package:flutter/material.dart';

class UserProfileHeaderStats extends StatelessWidget {
  final User user;

  const UserProfileHeaderStats({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5.0,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: <TextSpan>[
              TextSpan(
                text: '${user.followersCount}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: ' подписчиков'),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: <TextSpan>[
              TextSpan(
                text: '${user.followingCount}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: ' подписок'),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: <TextSpan>[
              TextSpan(
                text: '${user.postsCount}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: ' постов'),
            ],
          ),
        ),
      ],
    );
  }
}