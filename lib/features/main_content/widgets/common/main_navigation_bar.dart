import 'package:feedify/features/main_content/widgets/widget.dart';
import 'package:feedify/l10n/app_localizations.dart';
import 'package:feedify/repositories/user/models/user.dart';
import 'package:flutter/material.dart';

class MainNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final User? user;
  final bool isLoading;

  const MainNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.user,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      selectedIndex: selectedIndex,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      height: 50,
      destinations: [
        NavigationDestination(
          selectedIcon: const Icon(Icons.feed, size: 30),
          icon: const Icon(Icons.feed_outlined, size: 30),
          label: localization.mainNavigationBarFeedLabel,
        ),
        NavigationDestination(
          selectedIcon: const Icon(Icons.search, size: 30),
          icon: const Icon(Icons.search_outlined, size: 30),
          label: localization.mainNavigationBarSearchLabel,
        ),
        NavigationDestination(
          selectedIcon: UserAvatarWrapper(size: 30, child: NetworkAssetLoadingWidget(isLoading: isLoading, imagePath: user?.avatarUrl, fallback: UserNoAvatarWidget(username: user?.username ?? "?"))),
          icon: UserAvatarWrapper(size: 30, child: NetworkAssetLoadingWidget(isLoading: isLoading, imagePath: user?.avatarUrl, fallback: UserNoAvatarWidget(username: user?.username ?? "?"))),
          label: localization.mainNavigationBarUserLabel,
        ),
      ],
    );
  }
}
