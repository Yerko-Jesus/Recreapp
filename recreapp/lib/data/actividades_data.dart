// lib/data/actividades_data.dart
import '../models/actividad.dart';

/// Lista de actividades actuales.
/// Categorías definidas en la app: Letras, Números, Experimentos, Cocina, Manualidades
/// En este momento solo cargamos actividades para "Manualidades".
final List<Actividad> actividadesData = [
  // ====== MANUALIDADES ======
  Actividad(
    id: 'manualidades_maceteros_botella',
    categoria: 'Manualidades',
    titulo: 'Maceteros para Niños',
    descripcion:
    'Aprende a reutilizar botellas de plástico para crear maceteros y plantar flores, verduras o la planta que prefieras.',
    imagen: 'assets/images/macetero.png', // nueva imagen específica
    materiales: [
      'Botella plástica',
      'Tijeras',
      'Marcador',
      'Pinceles',
      'Pintura',
      'Tierra',
      'Semillas o planta'
    ],
    pasos:
    '1) Dibuja la figura que quieras en el centro de la botella (sugerencia: un búho).\n'
        '2) Con las tijeras, recorta la figura. Deja la parte de atrás recta y, por el frente, recorta las orejas del búho. Recuerda que la base de la botella será también la base del macetero.\n'
        '3) Elige un color base y pinta toda la botella por el interior. Luego, por el exterior, pinta los detalles del búho.\n'
        '4) Agrega la tierra y planta semillas o una de tus plantas favoritas.',
  ),

  Actividad(
    id: 'manualidades_cuaderno_viaje',
    categoria: 'Manualidades',
    titulo: 'Un cuaderno de viaje',
    descripcion:
    'Prepara y usa un cuaderno para registrar recuerdos antes, durante y después de un viaje.',
    imagen: 'assets/images/cuaderno_viaje.png', // nueva imagen específica
    materiales: [
      'Cuaderno o libreta',
      'Sobre de papel',
      'Pegamento',
      'Lápices o marcadores',
      'Fotos o recortes (opcional)'
    ],
    pasos:
    'Instrucciones antes del viaje:\n'
        '1) Destina un cuaderno solo para anotar los recuerdos de ese viaje en particular. Escribe en la portada el nombre del lugar y la fecha.\n'
        '2) Al final del cuaderno, pega un sobre de recuerdos para guardar mapas, flores, servilletas y todo lo que recojas durante el viaje.\n'
        '\n'
        'Instrucciones durante el viaje:\n'
        '1) Cada día, dedica unos minutos a escribir lo más importante o lo que quieras recordar.\n'
        '2) Para hacerlo más entretenido, incluye dibujos, fotografías y diálogos con personas del lugar u otros viajeros.\n'
        '3) Usa todos los sentidos en tu relato: describe lo que ves, hueles, comes y oyes.\n'
        '\n'
        'Instrucciones después del viaje:\n'
        '1) Al volver, comparte tu cuaderno con familia y amigos para revivir el viaje.\n'
        '2) Guarda el cuaderno en un lugar especial. Cuando lo leas en unos años, será como viajar en tu memoria.',
  ),
];
