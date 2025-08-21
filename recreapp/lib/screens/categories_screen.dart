// lib/screens/categories_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../theme.dart';
import 'activity_screen.dart';
import 'welcome_screen.dart';

class CategoriesScreen extends StatelessWidget {
  static const String routeName = '/categories';

  const CategoriesScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        WelcomeScreen.routeName,
            (route) => route.isFirst,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryPurple,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryPurple,
        title: const Text(
          'Categorías',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            _buildCategoryCard(
              context,
              icon: 'assets/images/lenguaje.png',
              label: 'Letras',
            ),
            _buildCategoryCard(
              context,
              icon: 'assets/images/matematicas.png',
              label: 'Números',
            ),
            _buildCategoryCard(
              context,
              icon: 'assets/images/ciencias.png',
              label: 'Experimentos',
            ),
            _buildCategoryCard(
              context,
              icon: 'assets/images/cocina.png',
              label: 'Cocina',
            ),
            _buildCategoryCard(
              context,
              icon: 'assets/images/pasatiempos.png',
              label: 'Juegos',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext ctx,
      {required String icon, required String label}) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          ctx,
          ActivityScreen.routeName,
          arguments: label,
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // tarjeta clara para buen contraste
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.asset(icon)),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black, // texto negro sobre tarjeta blanca
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
