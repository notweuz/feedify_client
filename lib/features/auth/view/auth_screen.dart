import 'package:feedify/app/app_data.dart';

import 'register_page.dart';
import 'login_page.dart';
import 'package:feedify/features/auth/widget/widget.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late PageController _pageController;
  static const _pages = [
    RegisterPage(),
    LoginPage()
  ];

  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPageIndex,
    );

    Future.microtask(() => _skipAuthorized());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _skipAuthorized() {
    if (AppData.userToken != null && AppData.userToken!.isNotEmpty) {
      Navigator.pushNamedAndRemoveUntil(context, '/app/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AuthNavigationBar(
        onDestinationSelected: (int index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        selectedIndex: _currentPageIndex,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                children: _pages,
              ),
            ),
          ],
        ),
      )
    );
  }
}
