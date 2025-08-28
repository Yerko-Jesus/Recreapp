// lib/main.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'theme.dart';
import 'supabase_keys.dart'; // contiene SupabaseKeys.supabaseUrl / supabaseAnonKey

// Pantallas
import 'screens/welcome_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/activity_screen.dart';
import 'screens/actividad_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/feedback_screen.dart';
import 'screens/teacher_dashboard_screen.dart';

import 'models/actividad.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Supabase (persistencia de sesión viene por defecto en supabase_flutter)
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
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      // ✅ SIEMPRE arrancamos en la bienvenida (inicio normal)
      initialRoute: WelcomeScreen.routeName,

      // Rutas “simples”
      routes: {
        WelcomeScreen.routeName: (_) => const WelcomeScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
        CategoriesScreen.routeName: (_) => const CategoriesScreen(),
        ActivityScreen.routeName: (_) => const ActivityScreen(),
        ActividadScreen.routeName: (_) => const ActividadScreen(),
        TeacherDashboardScreen.routeName: (_) => const TeacherDashboardScreen(),
        // OJO: FeedbackScreen necesita un argumento (Actividad), la resolvemos abajo en onGenerateRoute
      },

      // Rutas que necesitan argumentos
      onGenerateRoute: (settings) {
        if (settings.name == FeedbackScreen.routeName) {
          final act = settings.arguments as Actividad;
          return MaterialPageRoute(
            builder: (_) => FeedbackScreen(actividad: act),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
