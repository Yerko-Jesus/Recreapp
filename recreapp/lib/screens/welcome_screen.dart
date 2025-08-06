import 'package:flutter/material.dart';
import '../theme.dart';
import 'categories_screen.dart';


class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/welcome';  // <-- ruta aquí
  const WelcomeScreen({super.key});
  // ...

  // lib/screens/welcome_screen.dart
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppTheme.primaryPurple,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 64), // espacio superior

              // Título
              Text(
                '¡Bienvenido a\nRecreApp!',
                style: theme.textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Subtítulo
              Text(
                '¿Estás listo para jugar y aprender?',
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Ilustración de bienvenida
              SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/images/illustracion_bienvenida.png',
                  fit: BoxFit.contain,
                ),
              ),

              const Spacer(),

              // Único botón centrado
              Center(
                child: SizedBox(
                  width: 200, // ajuste de ancho
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentRed,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, CategoriesScreen.routeName);
                    },
                    child: Text(
                      'Comencemos',
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48), // espacio inferior
            ],
          ),
        ),
      ),
    );
  }
}
