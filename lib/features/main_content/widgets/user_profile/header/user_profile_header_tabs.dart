import 'package:flutter/material.dart';

class UserProfileHeaderTabs extends StatelessWidget {
  final TabController? tabController;

  const UserProfileHeaderTabs({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 0.0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      title: Row(children: const []),
      titleSpacing: 0,
      bottom: TabBar(
        tabs: [
          Tab(text: 'Посты'),
          Tab(text: 'Подписки'),
          Tab(text: 'Подписчики'),
        ],
        controller: tabController,
      ),
      expandedHeight: 0,
      flexibleSpace: const SizedBox.shrink(),
    );
  }
}
