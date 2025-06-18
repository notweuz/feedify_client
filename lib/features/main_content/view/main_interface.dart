import 'package:dio/dio.dart';
import 'package:feedify/app/app_data.dart';
import 'package:feedify/features/main_content/view/view.dart';
import 'package:feedify/features/main_content/widgets/widget.dart';
import 'package:feedify/repositories/auth/auth_repository.dart';
import 'package:feedify/repositories/auth/models/auth_dto.dart';
import 'package:feedify/repositories/auth/models/auth_status_dto.dart';
import 'package:flutter/material.dart';

class MainInterface extends StatefulWidget {
  const MainInterface({super.key});

  @override
  State<MainInterface> createState() => _MainInterfaceState();
}

class _MainInterfaceState extends State<MainInterface> {
  late PageController _pageController;
  static final _pages = [
    FeedListScreen(),
    Scaffold(body: Text('ало ало')),
    Scaffold(body: Text('ало ало')),
  ];

  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPageIndex,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _showRegisterIfUnauthorized();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MainNavigationBar(
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

  Future<void> _showRegisterIfUnauthorized() async {
    if (AppData.userToken == null) {
      Navigator.pushNamedAndRemoveUntil(context, '/auth/', (route) => false);
    } else {
      try {
        AuthDTO authDTO = AuthDTO(accessToken: AppData.userToken ?? "null");
        AuthStatusDTO authStatusDTO = await AuthRepository.validate(authDTO);
        if (!authStatusDTO.active) {
          if (mounted) Navigator.pushNamedAndRemoveUntil(context, '/auth/', (route) => false);
        }
      } on DioException {
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(context, '/auth/', (route) => false);
        }
      }
    }
  }
}
