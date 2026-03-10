import 'package:flutter/material.dart';
import 'package:news_app/core/themes/light_theme.dart';
import 'package:news_app/features/auth/login_screen.dart';

import 'core/data/local_data/prefrances_maneger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: lightTheme,
      home: LoginScreen(),
    );
  }
}
