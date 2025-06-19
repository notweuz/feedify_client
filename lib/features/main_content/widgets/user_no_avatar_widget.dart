import 'package:flutter/material.dart';

class UserNoAvatarWidget extends StatelessWidget {
  final String username;
  final double size;

  const UserNoAvatarWidget({
    super.key,
    required this.username,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.primary),
      child: Center(child: Text(username[0].toUpperCase())),
    );
  }
}
