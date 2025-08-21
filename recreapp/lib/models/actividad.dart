// lib/models/actividad.dart
class Actividad {
  final String id;
  final String categoria;     // Letras, Números, Experimentos, Cocina, Juegos
  final String titulo;
  final String descripcion;
  final String imagen;        // ruta en assets
  final List<String> materiales;
  final String pasos;         // instrucciones/pasos de la actividad

  const Actividad({
    required this.id,
    required this.categoria,
    required this.titulo,
    required this.descripcion,
    required this.imagen,
    required this.materiales,
    required this.pasos,
  });
}
