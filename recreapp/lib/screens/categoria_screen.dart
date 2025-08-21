// lib/screens/categoria_screen.dart
import 'package:flutter/material.dart';
import '../data/actividades_data.dart';
import 'activity_screen.dart';

class CategoriaScreen extends StatelessWidget {
  static const String routeName = '/categoria';

  const CategoriaScreen({super.key});

  /// Normaliza nombres para que "Lenguaje" cuente como "Letras",
  /// "Matematicas" como "Números", "Ciencias" como "Experimentos",
  /// "Pasatiempos" como "Juegos". Deja pasar los nombres nuevos tal cual.
  String _canonical(String value) {
    final v = value.trim().toLowerCase();
    switch (v) {
      case 'lenguaje':
      case 'letras':
        return 'Letras';
      case 'matematicas':
      case 'matemáticas':
      case 'números':
      case 'numeros':
        return 'Números';
      case 'ciencias':
      case 'experimentos':
        return 'Experimentos';
      case 'pasatiempos':
      case 'juegos':
        return 'Juegos';
      case 'cocina':
        return 'Cocina';
      default:
      // Por si alguna actividad trae otro formato, devolvemos capitalizado original
        return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String categoriaArg =
    ModalRoute.of(context)!.settings.arguments as String;

    final String categoria = _canonical(categoriaArg);

    // Filtra actividades comparando en formato canónico (acepta nombres viejos o nuevos)
    final lista = actividadesData
        .where((act) => _canonical(act.categoria) == categoria)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(categoria)),
      body: lista.isEmpty
          ? const Center(
        child: Text(
          'No hay actividades en esta categoría todavía.',
          style: TextStyle(fontSize: 16),
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
                width: 50,
                height: 50,
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
                  ActivityScreen.routeName,
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
