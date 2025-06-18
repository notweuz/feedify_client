import 'package:feedify/app/app_data.dart';
import 'package:feedify/app/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'app/feedify_app.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await AppData.readData();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const FeedifyApp(),
    )
  );
}

