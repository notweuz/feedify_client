import 'package:flutter/cupertino.dart';

class UserAvatarWrapper extends StatelessWidget {
  final double size;
  final Widget child;

  const UserAvatarWrapper({super.key, required this.size, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: child,
      ),
    );
  }
}
