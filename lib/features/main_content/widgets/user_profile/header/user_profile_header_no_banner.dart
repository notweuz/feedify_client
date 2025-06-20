import 'package:flutter/material.dart';

class UserProfileHeaderNoBanner extends StatelessWidget {
  const UserProfileHeaderNoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary
      ),
    );
  }
}