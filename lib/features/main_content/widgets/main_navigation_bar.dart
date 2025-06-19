import 'package:dio/dio.dart';
import 'package:feedify/app/app_data.dart';
import 'package:feedify/features/main_content/widgets/widget.dart';
import 'package:feedify/repositories/user/models/user_dto.dart';
import 'package:feedify/repositories/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

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
  UserDTO? _userDTO;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _getProfileInfo());
  }

  Future<void> _getProfileInfo() async {
    try {
      final user = await UserRepository.getSelfInfo();
      setState(() {
        _userDTO = user;
        _isLoading = false;
      });
    } on DioException catch (e) {
      // debugPrintStack(stackTrace: e.stackTrace);
      if (mounted) {
        if (e.response != null && (e.response?.statusCode == 401 || e.response?.statusCode == 403)) {
          AppData.userToken = null;
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          await AppData.saveData();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Произошла ошибка. Невозможно подключиться к серверу.',
              ),
              action: SnackBarAction(
                label: "Retry",
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
    return NavigationBar(
      onDestinationSelected: widget.onDestinationSelected,
      selectedIndex: widget.selectedIndex,
      destinations: [
        const NavigationDestination(
          selectedIcon: Icon(Icons.feed, size: 30),
          icon: Icon(Icons.feed_outlined, size: 30),
          label: 'Лента',
        ),
        const NavigationDestination(
          selectedIcon: Icon(Icons.search, size: 30),
          icon: Icon(Icons.search_outlined, size: 30),
          label: 'Поиск',
        ),
        if (_isLoading)
          NavigationDestination(
            selectedIcon: ClipOval(
              child: Shimmer(child: const SizedBox(width: 30, height: 30)),
            ),
            icon: ClipOval(
              child: Shimmer(child: const SizedBox(width: 30, height: 30)),
            ),
            label: '',
          )
        else if (_userDTO != null)
          NavigationDestination(
            selectedIcon: NavigationBarUserAvatar(
              userDTO: _userDTO!,
              size: 30,
              isSelected: true,
            ),
            icon: NavigationBarUserAvatar(userDTO: _userDTO!, size: 30),
            label: 'Профиль',
          ),
      ],
    );
  }
}
