// lib/screens/welcome_screen.dart
import 'package:flutter/material.dart';
import '../theme.dart';
import 'login_screen.dart';
import 'categories_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/';
  const WelcomeScreen({super.key});

  Future<void> _goLogin(BuildContext context) async {
    final auth = Supabase.instance.client.auth;
    // Si hay sesión, la cerramos antes de ir al login
    if (auth.currentUser != null) {
      await auth.signOut();
    }
    if (context.mounted) {
      Navigator.pushNamed(context, LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      backgroundColor: AppTheme.primaryPurple, // fondo morado
      appBar: AppBar(
        title: const Text('RecreApp'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            const Text(
              '¡Bienvenido a RecreApp!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white, // título en blanco
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Actividades entretenidas para aprender.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white), // subtítulo en blanco
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/illustracion_bienvenida.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Botón principal: si hay sesión → va a categorías; si no → va a login
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  if (current == null) {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  } else {
                    Navigator.pushNamed(context, CategoriesScreen.routeName);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: const Text('¡Comencemos!'),
              ),
            ),
            const SizedBox(height: 10),
            // Botón secundario SIEMPRE visible para ir al login/cambiar de cuenta
            SizedBox(
              height: 48,
              child: OutlinedButton(
                onPressed: () => _goLogin(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Cambiar de cuenta (login)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
