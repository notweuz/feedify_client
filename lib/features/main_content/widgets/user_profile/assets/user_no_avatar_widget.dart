import 'package:flutter/material.dart';

class UserNoAvatarWidget extends StatelessWidget {
  final String username;

  const UserNoAvatarWidget({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.primary),
      child: Center(child: Text(username[0].toUpperCase())),
    );
  }
}
