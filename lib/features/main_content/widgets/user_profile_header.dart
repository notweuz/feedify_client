import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:feedify/features/main_content/widgets/widget.dart';
import 'package:feedify/repositories/user/models/user.dart';
import 'package:flutter/material.dart';

class UserProfileHeader extends StatefulWidget {
  final User user;
  final bool isLoading;

  const UserProfileHeader({super.key, required this.user, required this.isLoading});

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
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 60),
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
                child: UserAvatarWidget(user: widget.user, size: 90),
              ),
              Text(
                widget.user.displayName!,
                style: Theme.of(context).textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w900),
              ),
              Text(
                "@${widget.user.username}",
                style: Theme.of(context).textTheme.headlineSmall
                    ?.copyWith(
                  fontSize: 18,
                  color: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.color
                      ?.withAlpha(175),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                spacing: 5.0,
                children: [
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: <TextSpan>[
                        TextSpan(
                          text: '${widget.user.followersCount}',
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
                          text: '${widget.user.followingCount}',
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
                          text: '${widget.user.postsCount}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: ' постов'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (widget.user.description.isNotEmpty)
                Text(
                  widget.user.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
            ],
          ),
        ),
      ],
    );
  }
}