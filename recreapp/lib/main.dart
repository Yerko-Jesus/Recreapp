// lib/main.dart
import 'package:flutter/material.dart';
import 'theme.dart';

import 'screens/welcome_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/categoria_screen.dart';
import 'screens/activity_screen.dart';
import 'screens/feedback_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecreApp',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.routeName,
      routes: {
        WelcomeScreen.routeName: (_) => const WelcomeScreen(),
        CategoriesScreen.routeName: (_) => const CategoriesScreen(),
        CategoriaScreen.routeName: (_) => const CategoriaScreen(),
        ActivityScreen.routeName: (_) => const ActivityScreen(),
        FeedbackScreen.routeName: (_) => const FeedbackScreen(),
      },
    );
  }
}
