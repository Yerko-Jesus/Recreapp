// lib/main.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_keys.dart';
import 'theme.dart';

import 'screens/welcome_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/activity_screen.dart';
import 'screens/actividad_screen.dart';
import 'screens/feedback_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Supabase con tus claves
  await Supabase.initialize(
    url: SupabaseKeys.supabaseUrl,
    anonKey: SupabaseKeys.supabaseAnonKey,
  );

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
        ActivityScreen.routeName: (_) => const ActivityScreen(),     // lista por categoría (recibe String)
        ActividadScreen.routeName: (_) => const ActividadScreen(),   // detalle de actividad (recibe Actividad)
        FeedbackScreen.routeName: (_) => const FeedbackScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
      },
    );
  }
}
