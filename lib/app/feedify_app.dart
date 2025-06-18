import 'package:dynamic_color/dynamic_color.dart';
import 'package:feedify/app/router.dart';
import 'package:feedify/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme.dart';

class FeedifyApp extends StatelessWidget {
  const FeedifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ThemeData lightTheme = getLightTheme(lightDynamic);
        ThemeData darkTheme = getDarkTheme(darkDynamic);

        return MaterialApp(
          title: 'Feedify',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          routes: routes,
        );
      },
    );
  }
}
