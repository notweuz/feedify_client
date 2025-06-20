import 'dart:async';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:feedify/app/app_data.dart';
import 'package:feedify/l10n/app_localizations.dart';
import 'package:feedify/repositories/user/models/user.dart';
import 'package:feedify/repositories/user/user_repository.dart';
import 'package:feedify/features/main_content/view/view.dart';
import 'package:feedify/features/main_content/widgets/widget.dart';
import 'package:flutter/material.dart';

class MainInterface extends StatefulWidget {
  const MainInterface({super.key});

  @override
  State<MainInterface> createState() => _MainInterfaceState();
}

class _MainInterfaceState extends State<MainInterface> {
  late PageController _pageController;
  User? _user;
  bool _isLoading = true;
  late final StreamSubscription<List<ConnectivityResult>>
  _connectivitySubscription;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
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
    _pageController.dispose();
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
    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1, thickness: 1, indent: 0, endIndent: 0),
          MainNavigationBar(
            onDestinationSelected: (int index) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            selectedIndex: _currentPageIndex,
            user: _user,
            isLoading: _isLoading,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              children: [
                FeedListScreen(),
                Scaffold(body: Text('ало ало')),
                if (_user != null && !_isLoading)
                  UserProfileScreen(
                    user: _user!,
                    showBackButton: false,
                    isLoading: _isLoading,
                  )
                else
                  const SizedBox(
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
