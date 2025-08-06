// lib/screens/categoria_screen.dart

import 'package:flutter/material.dart';
import '../models/actividad.dart';
import '../data/actividades_data.dart';

class CategoriaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String categoria =
    ModalRoute.of(context)!.settings.arguments as String;

    // Filtrar actividades según la categoría seleccionada
    final lista = actividadesData
        .where((act) => act.categoria == categoria)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(categoria)),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: lista.length,
        itemBuilder: (ctx, i) {
          final act = lista[i];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Image.asset(act.imagen, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(act.titulo),
              subtitle: Text(act.descripcion),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/actividad',
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
