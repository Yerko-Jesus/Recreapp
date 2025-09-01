// lib/data/actividades_data.dart
import '../models/actividad.dart';

final List<Actividad> actividadesData = [

  // =======================
  //       EXPERIMENTOS
  // =======================
  Actividad(
    id: 'exp_volcan',
    categoria: 'Experimentos',
    titulo: 'Planeando una erupción',
    descripcion:
    'Actividad sencilla y asombrosa: arma un volcán y provoca una erupción de “lava” con una mezcla segura.',
    imagen: 'assets/images/experimento_volcan.png',
    materiales: [
      'Volcán artesanal (arcilla/greta/plastilina, con ayuda de un adulto)',
      'Tubo de ensayo o recipiente similar',
      'Bicarbonato de sodio',
      'Vinagre',
      'Jabón líquido de platos',
      'Colorante rojo o jugo en polvo rojo',
    ],
    pasos: '''
1- Coloca el tubo dentro del volcán artesanal, simulando la chimenea (la boca será el cráter).
2- Añade 2 cucharadas de bicarbonato en el tubo.
3- Agrega 1 cucharada de jabón líquido para platos.
4- Echa 5–6 gotas de colorante rojo (o jugo en polvo) para simular la lava.
5- Vierte 30–40 ml de vinagre y observa la erupción.
''',
  ),

  Actividad(
    id: 'exp_flipbook',
    categoria: 'Experimentos',
    titulo: 'Tu propia mini película',
    descripcion:
    'Crea un folioscopio (flipbook) y anima dibujos simples cambiándolos levemente en cada hoja.',
    imagen: 'assets/images/flipbook.png',
    materiales: [
      'Hojas',
      'Cinta adhesiva',
      'Lápices'
    ],
    pasos: '''
1- Define cuántas páginas tendrá tu flipbook (empieza con ~10).
2- Asegúrate de que todas tengan el mismo tamaño y únelas con cinta por arriba.
3- Dibuja la secuencia cambiando un poco la imagen en cada página (pelota que rebota, alguien caminando, etc.).
4- Decora tus páginas con elementos simples, manteniendo cambios leves entre hojas.
5- Usa el dedo pulgar para pasar rápido las páginas y ver la animación.
''',
  ),

  // =======================
  //          LETRAS
  // =======================
  Actividad(
    id: 'let_rapanui_contar',
    categoria: 'Letras',
    titulo: 'Contando en Rapa Nui',
    descripcion:
    'Aprende a contar del 1 al 10 en Rapa Nui con esta guía breve y entretenida.',
    imagen: 'assets/images/rapanui_contar.png',
    materiales: [
      'Ganas de aprender',
    ],
    pasos: '''
Números del 1 al 10 en Rapa Nui:
1 – e tahi
2 – e rua
3 – e toru
4 – e hā
5 – e rima
6 – e ono
7 – e hitu
8 – e va\'u
9 – e iva
10 – ka ho\'e \'ahuru
''',
  ),

  Actividad(
    id: 'let_adivinanzas_chiloe',
    categoria: 'Letras',
    titulo: 'Adivinanzas de Chiloé',
    descripcion:
    'Juega a resolver adivinanzas tradicionales de Chiloé. Algunas respuestas son animales… ¡y otras no!',
    imagen: 'assets/images/adivinanzas_chiloe.png',
    materiales: [
      'Cuaderno o notas del teléfono',
      'Familia o amigos para jugar'
    ],
    pasos: '''
Adivinanzas cuya solución es un ANIMAL:
1- Llevo mi casa al hombro, camino sin una pata y voy marcando mi huella con un hilito de plata.
2- Barbitas de carne, piquito de hueso, rodillitas para atrás y andar muy tieso.
3- Vengo de las profundidades hacia el padre creador, tengo los hábitos negros y amarillo el corazón.
Respuestas: 1) Caracol  2) Gallo  3) Choro

Adivinanzas que involucran animales, pero la solución NO es un animal:
1- De la cordillera sale un torito panzón con el asta colorada y amarillo el corazón.
2- Una vaca blanca no le para cerco ni tranca.
3- Una niña en su balcón le dice a su pastor: trae un cordero, mañana, para hacer de comer hoy.
Respuestas: 1) El sol  2) La luna  3) El pastor se llama “Mañana”.
''',
  ),

  // =======================
  //          NÚMEROS
  // =======================
  Actividad(
    id: 'num_puzzle',
    categoria: 'Números',
    titulo: 'Puzle de números e imágenes',
    descripcion:
    'Crea 10 piezas de puzle: una mitad con el número (1–10) y la otra con la cantidad representada. ¡Empareja número con cantidad!',
    imagen: 'assets/images/puzzle_numeros.png',
    materiales: [
      'Cartulina blanca y de color',
      'Pegatinas',
      'Tijeras',
      'Pegamento',
      'Regla (opcional)',
    ],
    pasos: '''
1- Recorta 10 rectángulos iguales en cartulina blanca y divídelos en “piezas de puzle” (con lengüeta).
2- Con cartulina de color, recorta los números del 1 al 10 y pégalos en una mitad.
3- En la otra mitad, pega pegatinas (o dibuja) con la cantidad que corresponde a cada número.
''',
  ),

  Actividad(
    id: 'num_bowling_tubos',
    categoria: 'Números',
    titulo: 'Bowling con tubos numerados',
    descripcion:
    'Arma pinos con tubos de papel higiénico, numéralos del 1 al 10 y juega a derribarlos mientras practicas los números.',
    imagen: 'assets/images/bowling_tubos.png',
    materiales: [
      'Tubos de papel higiénico',
      'Témperas de colores',
      'Números adhesivos o lápices para escribirlos',
      'Papel',
      'Cinta adhesiva',
    ],
    pasos: '''
1- Pinta cada tubo de un color y numéralos del 1 al 10.
2- Haz una bola con papel, envuélvela con cinta y juega a derribar los pinos; di el número que tiraste.
3- (Opcional) Ordénalos de forma ascendente/descendente o agrúpalos en pares e impares.
''',
  ),

  // =======================
  //           COCINA
  // =======================
  Actividad(
    id: 'coc_queque_yogur',
    categoria: 'Cocina',
    titulo: 'Queque de yogur',
    descripcion:
    'Queque de yogur fácil y esponjoso. Rinde ~14 porciones. Duración aprox. 1 h 20 min.',
    imagen: 'assets/images/queque_yogur.png',
    materiales: [
      '5 huevos',
      '2 yogures pequeños (sabor a elección, ej. vainilla)',
      '1 taza de aceite',
      '1½ tazas de azúcar',
      '2 cdta. de polvos de hornear',
      '3 tazas de harina',
      'Ralladura de limón o naranja (opcional)',
      'Azúcar flor para espolvorear',
      'Molde enmantequillado y enharinado',
    ],
    pasos: '''
1- En un bol, bate huevos, yogur, aceite y azúcar a velocidad alta hasta integrar.
2- Agrega de una vez las 3 tazas de harina y bate a velocidad baja solo hasta incorporar.
3- Enmantequilla y enharina el molde.
4- Vierte la mezcla y hornea a 180 °C por ~45 min (horno eléctrico). En horno convencional, temperatura media ~45 min.
5- Deja entibiar, desmolda y espolvorea azúcar flor.
''',
  ),

  Actividad(
    id: 'coc_panqueques',
    categoria: 'Cocina',
    titulo: 'Panqueques básicos',
    descripcion:
    'Receta simple para 9–11 panqueques. Prep. 5 min; cocción 2–3 min por panqueque.',
    imagen: 'assets/images/panqueques.png',
    materiales: [
      '500 ml de leche',
      '2 huevos',
      '12 cucharadas de harina',
      '6 cucharaditas de azúcar',
      '(Opcional) Mantequilla o aceite para engrasar el sartén',
      '(Opcional) Relleno: manjar, crema chantilly o mermelada',
    ],
    pasos: '''
1- Mezcla leche, huevos, harina y azúcar hasta lograr masa homogénea sin grumos.
2- Calienta un sartén antiadherente a fuego medio y engrasa levemente si es necesario.
3- Vierte una porción de masa, gira el sartén para una capa delgada.
4- Cocina 1–2 min hasta dorar bordes; da vuelta y cocina 30–60 s más.
5- (Opcional) Rellena con manjar, chantilly o mermelada y enrolla.
''',
  ),

  // =======================
  //       MANUALIDADES
  // =======================
  Actividad(
    id: 'man_maceteros',
    categoria: 'Manualidades',
    titulo: 'Maceteros para Niños',
    descripcion:
    'Reutiliza botellas plásticas para crear maceteros y plantar semillas o una planta favorita.',
    imagen: 'assets/images/macetero.png',
    materiales: [
      'Botella plástica',
      'Tijeras',
      'Marcador',
      'Pinceles',
      'Pintura',
      'Tierra',
      'Semillas o un pequeño esqueje',
    ],
    pasos: '''
1- Dibuja en la botella la figura que quieras (p. ej., un búho).
2- Recorta la figura; deja la parte trasera recta y en el frente forma las “orejas”.
3- Pinta por dentro (color base) y por fuera (detalles). Deja secar.
4- Agrega tierra y planta semillas o un esqueje (Importante, haz un pequeño hoyo en la tierra para dejar la semilla).
''',
  ),

  Actividad(
    id: 'man_cuaderno_viaje',
    categoria: 'Manualidades',
    titulo: 'Un cuaderno de viaje',
    descripcion:
    'Convierte un cuaderno en un “diario de viaje”: anota recuerdos, pega mapas y dibuja para hacerlo inolvidable.',
    imagen: 'assets/images/cuaderno_viaje.png',
    materiales: [
      'Cuaderno o libreta',
      'Sobre de papel',
      'Pegamento',
      'Lápices (opcional)',
      'Fotografías/recortes (opcional)',
    ],
    pasos: '''
Antes del viaje:
1- Destina un cuaderno solo para ese viaje. Escribe portada con lugar y fecha.
2- Pega un sobre al final para guardar recuerdos (mapas, flores, servilletas, etc.).

Durante el viaje:
1- Cada día, toma unos minutos para anotar lo más destacado.
2- Incluye dibujos, fotos o diálogos. Usa todos tus sentidos: qué viste, oliste, comiste y oíste.

Después del viaje:
1- Comparte tu cuaderno con familia y amigos.
2- Guárdalo en un lugar especial; al releerlo, será como viajar en tu memoria.
''',
  ),
];
