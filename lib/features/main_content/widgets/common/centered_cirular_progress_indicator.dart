import 'package:flutter/material.dart';

class CenteredCircularProgressIndicator extends StatelessWidget {
  final double? value;

  const CenteredCircularProgressIndicator({super.key, this.value});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(value: value),
    );
  }
}