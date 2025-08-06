// lib/screens/activity_screen.dart
import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/actividad.dart';
import '../data/actividades_data.dart';

class ActivityScreen extends StatelessWidget {
  static const routeName = '/activities';

  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Leer la categoría pasada como argumento
    final category =
        ModalRoute.of(context)!.settings.arguments as String? ?? 'Sin categoría';

    // 2. Filtrar la lista global por esa categoría
    final actividades = actividadesData
        .where((act) => act.categoria == category)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryPurple,
        title: Text(
          category,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: actividades.isEmpty
          ? Center(
        child: Text(
          'No hay actividades en "$category".',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: actividades.length,
        itemBuilder: (ctx, i) {
          final act = actividades[i];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  act.imagen,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                act.titulo,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                act.descripcion,
                style: const TextStyle(fontSize: 14),
              ),
              onTap: () {
                showDialog(
                  context: ctx,
                  builder: (_) => AlertDialog(
                    title: Text(act.titulo),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Materiales:'),
                        for (var m in act.materiales)
                          Text('• $m', style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 8),
                        Text('Instrucciones:',
                            style:
                            const TextStyle(fontWeight: FontWeight.bold)),
                        Text(act.instrucciones),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cerrar'),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
