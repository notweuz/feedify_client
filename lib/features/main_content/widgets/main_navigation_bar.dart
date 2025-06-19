import 'dart:async';
import 'package:dio/dio.dart';
import 'package:feedify/app/app_data.dart';
import 'package:feedify/features/main_content/widgets/widget.dart';
import 'package:feedify/l10n/app_localizations.dart';
import 'package:feedify/repositories/user/models/user.dart';
import 'package:feedify/repositories/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MainNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const MainNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  User? _user;
  bool _isLoading = true;
  late final StreamSubscription<List<ConnectivityResult>>
  _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) {
      if (results.any((result) => result != ConnectivityResult.none) &&
          _isLoading) {
        _getProfileInfo();
      }
    });

    Future.microtask(() => _getProfileInfo());
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _getProfileInfo() async {
    final localization = AppLocalizations.of(context)!;
    try {
      final user = await UserRepository.getSelfInfo();
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } on DioException catch (e) {
      if (mounted) {
        if (e.response != null &&
            (e.response?.statusCode == 401 || e.response?.statusCode == 403)) {
          AppData.userToken = null;
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          await AppData.saveData();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                localization.mainContentNetworkSnackBarErrorMessage,
              ),
              action: SnackBarAction(
                label: localization.mainContentNetworkSnackBarErrorButtonLabel,
                onPressed: _getProfileInfo,
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return NavigationBar(
      onDestinationSelected: widget.onDestinationSelected,
      selectedIndex: widget.selectedIndex,
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
        if (_isLoading)
          NavigationDestination(
            selectedIcon: ClipOval(
              child: Shimmer(child: const SizedBox(width: 30, height: 30)),
            ),
            icon: ClipOval(
              child: Shimmer(child: const SizedBox(width: 30, height: 30)),
            ),
            label: localization.mainNavigationBarUserLabel,
          )
        else if (_user != null)
          NavigationDestination(
            selectedIcon: NavigationBarUserAvatar(
              user: _user!,
              size: 30,
              isSelected: true,
            ),
            icon: NavigationBarUserAvatar(user: _user!, size: 30),
            label: localization.mainNavigationBarUserLabel,
          ),
      ],
    );
  }
}
