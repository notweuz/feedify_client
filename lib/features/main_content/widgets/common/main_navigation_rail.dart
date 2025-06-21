import 'package:feedify/features/main_content/widgets/widget.dart';
import 'package:feedify/l10n/app_localizations.dart';
import 'package:feedify/repositories/user/models/user.dart';
import 'package:flutter/material.dart';

class MainNavigationRail extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final User? user;
  final bool isLoading;

  const MainNavigationRail({
    super.key,
    required this.onDestinationSelected,
    this.user,
    required this.isLoading,
    required this.selectedIndex,
  });

  @override
  State<MainNavigationRail> createState() => _MainNavigationRailState();
}

class _MainNavigationRailState extends State<MainNavigationRail> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Row(
      children: [
        SizedBox(
          child: NavigationRail(
            selectedIndex: widget.selectedIndex,
            onDestinationSelected: widget.onDestinationSelected,
            destinations: [
              NavigationRailDestination(
                selectedIcon: const Icon(Icons.feed, size: 20),
                icon: const Icon(Icons.feed_outlined, size: 20),
                label: Text(localization.mainNavigationBarFeedLabel),
              ),
              NavigationRailDestination(
                selectedIcon: const Icon(Icons.search, size: 20),
                icon: const Icon(Icons.search_outlined, size: 20),
                label: Text(localization.mainNavigationBarSearchLabel),
              ),
              NavigationRailDestination(
                selectedIcon: UserAvatarWrapper(
                  size: 20,
                  child: NetworkAssetLoadingWidget(
                    isLoading: widget.isLoading,
                    imagePath: widget.user?.avatarUrl,
                    fallback: UserNoAvatarWidget(
                      username: widget.user?.username ?? "?",
                    ),
                  ),
                ),
                icon: UserAvatarWrapper(
                  size: 20,
                  child: NetworkAssetLoadingWidget(
                    isLoading: widget.isLoading,
                    imagePath: widget.user?.avatarUrl,
                    fallback: UserNoAvatarWidget(
                      username: widget.user?.username ?? "?",
                    ),
                  ),
                ),
                label: Text(localization.mainNavigationBarUserLabel),
              ),
            ],
          ),
        ),
        const VerticalDivider(width: 1, thickness: 1),
      ],
    );
  }
}