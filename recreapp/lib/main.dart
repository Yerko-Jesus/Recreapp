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

  await Supabase.initialize(
    url: SupabaseKeys.supabaseUrl,
    anonKey: SupabaseKeys.supabaseAnonKey,
    authOptions: const FlutterAuthClientOptions(
      autoRefreshToken: true, // refresca tokens, la sesión se mantiene hasta cerrar
    ),
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
        ActivityScreen.routeName: (_) => const ActivityScreen(),
        ActividadScreen.routeName: (_) => const ActividadScreen(),
        FeedbackScreen.routeName: (_) => const FeedbackScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
      },
    );
  }
}
