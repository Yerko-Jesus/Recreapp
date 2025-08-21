// lib/screens/activity_screen.dart
import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/actividad.dart';
import '../data/actividades_data.dart';
import 'actividad_screen.dart';

class ActivityScreen extends StatelessWidget {
  static const String routeName = '/activities';

  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recibimos la categoría como String desde CategoriesScreen
    final String categoria =
    ModalRoute.of(context)!.settings.arguments as String;

    // Filtramos actividades por categoría
    final List<Actividad> lista = actividadesData
        .where((a) => a.categoria == categoria)
        .toList();

    return Scaffold(
      backgroundColor: AppTheme.primaryPurple,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryPurple,
        title: Text(
          categoria,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: lista.isEmpty
          ? const Center(
        child: Text(
          'No hay actividades en esta categoría.',
          style: TextStyle(color: Colors.white),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: lista.length,
        itemBuilder: (ctx, i) {
          final act = lista[i];
          return Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  act.imagen,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                act.titulo,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                act.descripcion,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black87),
              ),
              onTap: () {
                // Al detalle le pasamos el objeto Actividad
                Navigator.pushNamed(
                  ctx,
                  ActividadScreen.routeName,
                  arguments: act,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
