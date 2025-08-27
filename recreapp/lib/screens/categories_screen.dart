import 'package:flutter/material.dart';
import '../theme.dart';
import 'category_list_screen.dart';

class CategoriesScreen extends StatelessWidget {
  static const String routeName = '/categories';
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cats = [
      ('assets/images/lenguaje.png', 'Letras'),
      ('assets/images/matematicas.png', 'Números'),
      ('assets/images/ciencias.png', 'Experimentos'),
      ('assets/images/cocina.png', 'Cocina'),
      ('assets/images/pasatiempos.png', 'Manualidades'),
    ];

    return Scaffold(
      backgroundColor: AppTheme.primaryPurple,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryPurple,
        title: const Text(
          'Categorías',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: cats.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (ctx, i) {
            final (icon, label) = cats[i];
            return _buildCategoryCard(ctx, icon: icon, label: label);
          },
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
          CategoryListScreen.routeName,
          arguments: label, // pasamos el nombre de la categoría
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
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black, // el card es claro; si prefieres blanco, cámbialo
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
