import 'package:flutter/material.dart';

class FeedListScreen extends StatefulWidget {
  @override
  _FeedListScreenState createState() => _FeedListScreenState();
}

class _FeedListScreenState extends State<FeedListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('экран ленты')
      )
    );
  }
}