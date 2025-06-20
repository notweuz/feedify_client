import 'package:flutter/material.dart';

class UserProfileHeaderTabs extends StatelessWidget {
  final TabController? tabController;

  const UserProfileHeaderTabs({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        TabBar(
          tabs: const [
            Tab(text: 'Посты', height: 60),
            Tab(text: 'Подписки', height: 60),
            Tab(text: 'Подписчики', height: 60),
          ],
          controller: tabController,
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
