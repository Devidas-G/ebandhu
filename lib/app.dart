import 'package:flutter/material.dart';

import 'features/auth/presentation/pages/auth_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
      home: AuthPage(),
    );
  }
}
