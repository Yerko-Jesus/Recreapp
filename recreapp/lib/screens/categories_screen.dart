// lib/screens/categories_screen.dart
import 'package:flutter/material.dart';
import '../theme.dart';
import 'activity_screen.dart';
// si la estructura de carpetas lo requiere:
// import '../screens/activity_screen.dart';

class CategoriesScreen extends StatelessWidget {
  static const String routeName = '/categories';

  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              label: 'Lenguaje',
            ),
            _buildCategoryCard(
              context,
              icon: 'assets/images/matematicas.png',
              label: 'Matemáticas',
            ),
            _buildCategoryCard(
              context,
              icon: 'assets/images/ciencias.png',
              label: 'Ciencias',
            ),
            _buildCategoryCard(
              context,
              icon: 'assets/images/cocina.png',
              label: 'Cocina',
            ),
            _buildCategoryCard(
              context,
              icon: 'assets/images/pasatiempos.png',
              label: 'Pasatiempos',
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
          color: AppTheme.cardBackground,
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
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

