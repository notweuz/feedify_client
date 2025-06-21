import 'dart:io';
import 'package:feedify/features/main_content/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:feedify/repositories/user/models/user.dart';

class UserProfileScreen extends StatefulWidget {
  final User user;
  final bool showBackButton;
  final bool isLoading;

  const UserProfileScreen({
    super.key,
    required this.user,
    required this.showBackButton,
    required this.isLoading,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final isWindows = Platform.isWindows;

    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.user.description,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width - 32);

    final descriptionHeight = textPainter.height;
    final headerHeight = (isWindows ? 270 : 310) + descriptionHeight;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: SizedBox(
              height: headerHeight,
              child: UserProfileHeader(
                user: widget.user,
                isLoading: widget.isLoading,
              ),
            ),
          ),
          UserProfileHeaderTabs(tabController: tabController!),
        ],
        body: TabBarView(
          controller: tabController,
          children: [
            ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 20,
              itemBuilder: (context, index) =>
                  ListTile(title: Text('Элемент #$index')),
            ),
            Center(child: Text('Подписки')),
            Center(child: Text('Подписчики')),
          ],
        ),
      ),
    );
  }
}
