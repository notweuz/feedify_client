import 'package:feedify/repositories/user/models/user.dart';
import 'package:flutter/material.dart';

class NavigationBarUserAvatar extends StatelessWidget {
  final User user;
  final double size;
  final bool isSelected;

  const NavigationBarUserAvatar({
    super.key,
    required this.user,
    required this.size,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final icon = isSelected ? Icons.person : Icons.person_outline;

    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: user.avatarUrl != null && user.avatarUrl!.isNotEmpty
            ? Stack(
                children: [
                  Image.network(
                    user.avatarUrl!,
                    fit: BoxFit.cover,
                    width: size,
                    height: size,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(icon, size: size);
                    },
                  ),
                ],
              )
            : Icon(icon, size: size),
      ),
    );
  }
}
