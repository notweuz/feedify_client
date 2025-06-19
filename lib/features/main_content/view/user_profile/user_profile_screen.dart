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
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: UserProfileHeader(user: widget.user, isLoading: widget.isLoading),
            ),
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
