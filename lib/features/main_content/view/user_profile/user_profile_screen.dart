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

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 300,
              child: UserProfileHeader(
                user: widget.user,
                isLoading: widget.isLoading,
              ),
            ),
          ),
          SliverAppBar(
            pinned: true,
            toolbarHeight: 35.0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: Row(children: const []),
            titleSpacing: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(onPressed: () {}, child: Text("тест")),
                      ),
                      Expanded(
                        child: TextButton(onPressed: () {}, child: Text("тест")),
                      ),
                      Expanded(
                        child: TextButton(onPressed: () {}, child: Text("тест")),
                      ),
                    ],
                  ),
                  const Divider(height: 1, thickness: 1, indent: 0, endIndent: 0)
                ],
              ),
            ),
            expandedHeight: 0,
            flexibleSpace: const SizedBox.shrink(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((
              BuildContext context,
              int index,
            ) {
              return ListTile(title: Text('Элемент #$index'));
            }, childCount: 20),
          ),
        ],
      ),
    );
  }
}
