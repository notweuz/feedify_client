import 'package:feedify/app/app_data.dart';
import 'package:feedify/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'app/feedify_app.dart';

main() async {
  await dotenv.load(fileName: ".env");
  await AppData.readData();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const FeedifyApp(),
    ),
  );
}
