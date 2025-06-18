import 'package:flutter/material.dart';

class AuthNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const AuthNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      selectedIndex: selectedIndex,
      destinations: const [
        NavigationDestination(
          selectedIcon: Icon(Icons.app_registration),
          icon: Icon(Icons.app_registration_outlined),
          label: "Регистрация",
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.login),
          icon: Icon(Icons.login_outlined),
          label: "Вход",
        ),
      ],
    );
  }
}

