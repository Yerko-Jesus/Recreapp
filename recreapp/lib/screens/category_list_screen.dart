import 'package:flutter/material.dart';
import '../theme.dart';
import '../data/actividades_data.dart';
import '../models/actividad.dart';
import 'activity_screen.dart';

class CategoryListScreen extends StatelessWidget {
  static const String routeName = '/category-list';
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String categoria =
    ModalRoute.of(context)!.settings.arguments as String;

    final List<Actividad> lista = actividadesData
        .where((a) => a.categoria.toLowerCase() == categoria.toLowerCase())
        .toList();

    return Scaffold(
      backgroundColor: AppTheme.primaryPurple,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryPurple,
        title: Text(categoria, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: lista.isEmpty
          ? const Center(
        child: Text(
          'No hay actividades en esta categoría aún.',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: lista.length,
        itemBuilder: (ctx, i) {
          final act = lista[i];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Image.asset(
                act.imagen,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),
              title: Text(act.titulo,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16)),
              subtitle: Text(
                act.descripcion,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Navigator.pushNamed(
                  ctx,
                  ActivityScreen.routeName,
                  arguments: act, // pasamos la Actividad completa
                );
              },
            ),
          );
        },
      ),
    );
  }
}
