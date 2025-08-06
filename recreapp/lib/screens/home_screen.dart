import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> categorias = [
    {'nombre': 'Lenguaje', 'imagen': 'assets/images/lenguaje.png'},
    {'nombre': 'Matemáticas', 'imagen': 'assets/images/matematicas.png'},
    {'nombre': 'Ciencias', 'imagen': 'assets/images/ciencias.png'},
    {'nombre': 'Cocina', 'imagen': 'assets/images/cocina.png'},
    {'nombre': 'Pasatiempos', 'imagen': 'assets/images/pasatiempos.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RecreApp'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columnas
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: categorias.length,
        itemBuilder: (ctx, index) {
          final categoria = categorias[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/categoria',
                arguments: categoria['nombre'],
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    categoria['imagen']!,
                    height: 80,
                  ),
                  SizedBox(height: 10),
                  Text(
                    categoria['nombre']!,
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

