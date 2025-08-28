// lib/screens/activity_screen.dart
import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/actividad.dart';
import '../data/actividades_data.dart' as data;
import 'actividad_screen.dart';

class ActivityScreen extends StatelessWidget {
  static const String routeName = '/activity';
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recibe la categoría seleccionada
    final String categoria =
    ModalRoute.of(context)!.settings.arguments as String;

    // Filtra usando la lista correcta: data.actividadesData
    final List<Actividad> lista = data.actividadesData
        .where((a) =>
    a.categoria.trim().toLowerCase() ==
        categoria.trim().toLowerCase())
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryPurple,
        title: Text(
          categoria,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: AppTheme.primaryPurple,
      body: lista.isEmpty
          ? const Center(
        child: Text(
          'No hay actividades para esta categoría aún.',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: lista.length,
        itemBuilder: (ctx, i) {
          final act = lista[i];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Image.asset(
                act.imagen,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),
              title: Text(act.titulo),
              subtitle: Text(
                act.descripcion,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Navigator.pushNamed(
                  ctx,
                  ActividadScreen.routeName,
                  arguments: act, // pasa el objeto Actividad
                );
              },
            ),
          );
        },
      ),
    );
  }
}
