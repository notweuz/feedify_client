import 'package:dio/dio.dart';
import 'package:feedify/features/auth/widget/error_dialog.dart';
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
      debugPrintStack(stackTrace: e.stackTrace);
      _isLoading = false;
      if (mounted) {
        ErrorDialog.show(
          context,
          title: "Ошибка",
          message:
              "Произошла ошибка при загрузке профиля. Обратитесь в тех-поддержку",
        );
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
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
