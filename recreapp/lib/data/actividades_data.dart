// lib/data/actividades_data.dart
import '../models/actividad.dart';

/// Cat: Letras, Números, Experimentos, Cocina, Juegos
final List<Actividad> actividadesData = [
  // Letras
  Actividad(
    id: 'letras-1',
    categoria: 'Letras',
    titulo: 'Sopa de letras',
    descripcion: 'Encuentra palabras ocultas para reforzar vocabulario.',
    imagen: 'assets/images/sopa_letras.png',
    materiales: ['Lápiz', 'Goma', 'Hoja impresa con sopa de letras'],
    pasos: '1) Observa la sopa de letras.\n'
        '2) Busca las palabras de la lista.\n'
        '3) Rodéalas o subráyalas.\n'
        '4) Revisa que no falte ninguna.',
  ),
  Actividad(
    id: 'letras-2',
    categoria: 'Letras',
    titulo: 'Cuenta cuentos',
    descripcion: 'Lectura guiada para desarrollar la comprensión lectora.',
    imagen: 'assets/images/cuentacuentos.png',
    materiales: ['Cuento impreso o digital', 'Marcadores de colores'],
    pasos: '1) Lee el cuento en voz alta.\n'
        '2) Subraya palabras nuevas.\n'
        '3) Comenta qué pasó al inicio, nudo y desenlace.',
  ),

  // Números
  Actividad(
    id: 'numeros-1',
    categoria: 'Números',
    titulo: 'Bingo de números',
    descripcion: 'Reconocimiento de números con una dinámica entretenida.',
    imagen: 'assets/images/bingo_numeros.png',
    materiales: ['Cartillas de bingo', 'Fichas/porotos', 'Bolitas con números'],
    pasos: '1) Entrega cartillas y fichas.\n'
        '2) Saca números al azar.\n'
        '3) Marca coincidencias.\n'
        '4) ¡Gana quien complete una línea!',
  ),
  Actividad(
    id: 'numeros-2',
    categoria: 'Números',
    titulo: 'Sumas con fichas',
    descripcion: 'Aprende sumas simples manipulando objetos.',
    imagen: 'assets/images/sumas_fichas.png',
    materiales: ['Fichas o porotos', 'Hoja y lápiz'],
    pasos: '1) Forma dos grupos de fichas.\n'
        '2) Cuenta cada grupo.\n'
        '3) Júntalos y vuelve a contar.\n'
        '4) Escribe la suma.',
  ),

  // Experimentos
  Actividad(
    id: 'exp-1',
    categoria: 'Experimentos',
    titulo: 'Germinar semillas',
    descripcion: 'Observa cómo crecen las plantas desde una semilla.',
    imagen: 'assets/images/semillas.png',
    materiales: ['Algodón', 'Frasco', 'Semillas', 'Agua'],
    pasos: '1) Humedece el algodón y ponlo en el frasco.\n'
        '2) Agrega 2–3 semillas.\n'
        '3) Deja el frasco con luz indirecta.\n'
        '4) Observa a diario y agrega agua si hace falta.',
  ),
  Actividad(
    id: 'exp-2',
    categoria: 'Experimentos',
    titulo: 'Laberinto de agua',
    descripcion: 'Explora la capilaridad del agua con colorantes.',
    imagen: 'assets/images/laberinto_agua.png',
    materiales: ['Vasos', 'Papel toalla', 'Colorantes', 'Agua'],
    pasos: '1) Coloca agua con color en vasos alternados.\n'
        '2) Conecta los vasos con tiras de papel.\n'
        '3) Observa cómo el color viaja por el papel.\n'
        '4) Describe lo ocurrido.',
  ),

  // Cocina
  Actividad(
    id: 'cook-1',
    categoria: 'Cocina',
    titulo: 'Limonada mágica',
    descripcion: 'Prepara una limonada refrescante y mide cantidades.',
    imagen: 'assets/images/limonada.png',
    materiales: ['Limones', 'Agua', 'Azúcar', 'Jarra', 'Cucharas medidoras'],
    pasos: '1) Exprime los limones.\n'
        '2) Agrega agua y azúcar a gusto.\n'
        '3) Revuelve y sirve con hielo.',
  ),
  Actividad(
    id: 'cook-2',
    categoria: 'Cocina',
    titulo: 'Batido de frutas',
    descripcion: 'Licúa frutas para crear un batido nutritivo.',
    imagen: 'assets/images/batido.png',
    materiales: ['Frutas', 'Leche o yogurt', 'Licuadora', 'Vaso'],
    pasos: '1) Lava y corta las frutas.\n'
        '2) Licúa con leche o yogurt.\n'
        '3) Sirve y disfruta.',
  ),

  // Juegos
  Actividad(
    id: 'juegos-1',
    categoria: 'Juegos',
    titulo: 'Origami fácil',
    descripcion: 'Crea figuras de papel siguiendo instrucciones.',
    imagen: 'assets/images/origami.png',
    materiales: ['Hojas cuadradas de papel'],
    pasos: '1) Dobla el papel siguiendo el diagrama.\n'
        '2) Marca bien los pliegues.\n'
        '3) Decora la figura al final.',
  ),
  Actividad(
    id: 'juegos-2',
    categoria: 'Juegos',
    titulo: 'Pintura con esponjas',
    descripcion: 'Pinta con texturas usando esponjas.',
    imagen: 'assets/images/pintura.png',
    materiales: ['Pinturas', 'Esponjas', 'Cartulina', 'Delantal'],
    pasos: '1) Prepara el espacio y protege la mesa.\n'
        '2) Moja la esponja en pintura.\n'
        '3) Presiona suavemente sobre la cartulina.\n'
        '4) Deja secar.',
  ),
];
