// lib/screens/categories_screen.dart
import 'package:flutter/material.dart';
import '../theme.dart';
import 'activity_screen.dart';

class CategoriesScreen extends StatelessWidget {
  static const String routeName = '/categories';
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categorias = <_Cat>[
      _Cat('Letras', 'assets/images/lenguaje.png'),
      _Cat('Números', 'assets/images/matematicas.png'),
      _Cat('Experimentos', 'assets/images/ciencias.png'),
      _Cat('Cocina', 'assets/images/cocina.png'),
      _Cat('Manualidades', 'assets/images/pasatiempos.png'),
    ];

    return Scaffold(
      backgroundColor: AppTheme.primaryPurple, // 🎨 Fondo morado
      appBar: AppBar(
        backgroundColor: AppTheme.primaryPurple,
        title: const Text(
          'Categorías',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: AppTheme.primaryPurple, // asegura morado detrás del Grid
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: categorias
                .map(
                  (c) => _buildCategoryCard(
                context,
                icon: c.icon,
                label: c.nombre,
              ),
            )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext ctx, {
        required String icon,
        required String label,
      }) {
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
          color: AppTheme.cardBackground, // tarjetas claras sobre morado
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
                color: Colors.black,
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

class _Cat {
  final String nombre;
  final String icon;
  _Cat(this.nombre, this.icon);
}
