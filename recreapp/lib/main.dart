import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_config.dart';
import 'theme.dart';

// Pantallas
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/category_list_screen.dart'; // <- NUEVA ruta
import 'screens/activity_screen.dart';      // <- Detalle de actividad

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
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
      initialRoute: WelcomeScreen.routeName,
      routes: {
        WelcomeScreen.routeName: (_) => const WelcomeScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
        CategoriesScreen.routeName: (_) => const CategoriesScreen(),
        CategoryListScreen.routeName: (_) => const CategoryListScreen(), // <- agregado
        ActivityScreen.routeName: (_) => const ActivityScreen(),         // <- asegúrate que exista
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
