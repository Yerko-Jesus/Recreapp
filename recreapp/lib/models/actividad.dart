// lib/models/actividad.dart

class Actividad {
  final String id;
  final String titulo;
  final String descripcion;
  final String categoria;
  final String imagen;       // Ruta a asset, e.g. 'assets/images/sopa_letras.png'
  final List<String> materiales;
  final String instrucciones;

  Actividad({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.categoria,
    required this.imagen,
    required this.materiales,
    required this.instrucciones,
  });
}
