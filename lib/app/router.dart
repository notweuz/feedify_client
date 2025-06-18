import 'package:feedify/features/main_content/main_content.dart';
import 'package:feedify/features/auth/auth.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => MainInterface(),
  '/auth/': (context) => AuthScreen(),
};