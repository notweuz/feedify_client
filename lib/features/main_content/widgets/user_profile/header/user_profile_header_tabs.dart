import 'dart:io';
import 'package:flutter/material.dart';

class UserProfileHeaderTabs extends StatelessWidget {
  final TabController? tabController;

  const UserProfileHeaderTabs({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    final isWindows = Platform.isWindows;

    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        TabBar(
          tabs: const [
            Tab(text: 'Посты'),
            Tab(text: 'Подписки'),
            Tab(text: 'Подписчики'),
          ],
          controller: tabController,
        ),
        isWindows: isWindows,
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final bool isWindows;

  _SliverAppBarDelegate(this.tabBar, {required this.isWindows});

  @override
  double get minExtent => isWindows ? 50 : 80;

  @override
  double get maxExtent => isWindows ? 50 : 80;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SizedBox(height: isWindows ? 50 : 80, child: tabBar),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
