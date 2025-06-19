import 'package:feedify/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AuthNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const AuthNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      selectedIndex: selectedIndex,
      destinations: [
        NavigationDestination(
          selectedIcon: const Icon(Icons.app_registration),
          icon: const Icon(Icons.app_registration_outlined),
          label: localization.registerPageLabel,
        ),
        NavigationDestination(
          selectedIcon: const Icon(Icons.login),
          icon: const Icon(Icons.login_outlined),
          label: localization.loginPageLabel,
        ),
      ],
    );
  }
}

