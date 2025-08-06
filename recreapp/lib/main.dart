// lib/main.dart
import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/activity_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecreApp',
      theme: AppTheme.lightTheme,
      initialRoute: WelcomeScreen.routeName,
      routes: {
        WelcomeScreen.routeName: (_) => const WelcomeScreen(),
        CategoriesScreen.routeName: (_) => const CategoriesScreen(),
        ActivityScreen.routeName:   (_) => const ActivityScreen(),
      },
    );
  }
}



