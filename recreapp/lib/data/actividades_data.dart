// lib/data/actividades_data.dart

import '../models/actividad.dart';

final List<Actividad> actividadesData = [
  Actividad(
    id: 'leng1',
    titulo: 'Sopa de Letras',
    descripcion: 'Encuentra palabras relacionadas con animales.',
    categoria: 'Lenguaje',
    imagen: 'assets/images/sopa_letras.png',
    materiales: ['Hoja impresa', 'Lápiz'],
    instrucciones:
    'Entrega la hoja con la cuadrícula. Los niños deben rodear las palabras escondidas.',
  ),
  Actividad(
    id: 'leng2',
    titulo: 'Cuentacuentos',
    descripcion: 'Inventa un cuento en conjunto a partir de tres palabras.',
    categoria: 'Lenguaje',
    imagen: 'assets/images/cuentacuentos.png',
    materiales: ['Tarjetas con palabras'],
    instrucciones:
    'Cada niño saca una tarjeta y aporta una frase para construir un cuento colectivo.',
  ),

  Actividad(
    id: 'mate1',
    titulo: 'Bingo de Números',
    descripcion: 'Juego de bingo para reforzar el reconocimiento de números.',
    categoria: 'Matemáticas',
    imagen: 'assets/images/bingo_numeros.png',
    materiales: ['Tablero de bingo', 'Fichas numeradas'],
    instrucciones:
    'El facilitador canta números y los niños marcan en su tablero.',
  ),
  Actividad(
    id: 'mate2',
    titulo: 'Sumas con Fichas',
    descripcion: 'Practica sumas usando fichas de colores.',
    categoria: 'Matemáticas',
    imagen: 'assets/images/sumas_fichas.png',
    materiales: ['Fichas de colores', 'Cartulina'],
    instrucciones:
    'Coloca 3 fichas azules y 2 rojas. Pregunta: ¿Cuántas en total?',
  ),

  Actividad(
    id: 'cien1',
    titulo: 'Semillas en Vasos',
    descripcion: 'Planta semillas y observa su crecimiento.',
    categoria: 'Ciencias',
    imagen: 'assets/images/semillas.png',
    materiales: ['Vasos plásticos', 'Tierra', 'Semillas'],
    instrucciones:
    'Llena el vaso, siembra la semilla y riega. Registra su altura cada día.',
  ),
  Actividad(
    id: 'cien2',
    titulo: 'Laberinto de Agua',
    descripcion: 'Comprende conceptos de flujo de agua.',
    categoria: 'Ciencias',
    imagen: 'assets/images/laberinto_agua.png',
    materiales: ['Cartón', 'Pajitas', 'Agua'],
    instrucciones:
    'Construye un laberinto con pajitas y deja correr el agua por él.',
  ),

  Actividad(
    id: 'coci1',
    titulo: 'Limonada Casera',
    descripcion: 'Prepara una limonada simple.',
    categoria: 'Cocina',
    imagen: 'assets/images/limonada.png',
    materiales: ['Limones', 'Agua', 'Azúcar', 'Vaso'],
    instrucciones:
    'Exprime 2 limones, mezcla con agua y azúcar al gusto. ¡A disfrutar!',
  ),
  Actividad(
    id: 'coci2',
    titulo: 'Batido de Frutas',
    descripcion: 'Mezcla frutas para un batido nutritivo.',
    categoria: 'Cocina',
    imagen: 'assets/images/batido.png',
    materiales: ['Plátano', 'Leche', 'Frutas'],
    instrucciones:
    'Corta la fruta, licúa con leche y sirve.',
  ),

  Actividad(
    id: 'pasi1',
    titulo: 'Origami Simple',
    descripcion: 'Pliega papel para crear figuras.',
    categoria: 'Pasatiempos',
    imagen: 'assets/images/origami.png',
    materiales: ['Papel cuadrado'],
    instrucciones:
    'Sigue los pasos de origami para hacer un barco.',
  ),
  Actividad(
    id: 'pasi2',
    titulo: 'Pintura Libre',
    descripcion: 'Deja fluir tu creatividad con pintura.',
    categoria: 'Pasatiempos',
    imagen: 'assets/images/pintura.png',
    materiales: ['Pinturas', 'Pinceles', 'Papel'],
    instrucciones:
    'Pinta lo que imagines. No hay límites.',
  ),
];
