// lib/screens/actividad_screen.dart

import 'package:flutter/material.dart';
import '../models/actividad.dart';

class ActividadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final act = ModalRoute.of(context)!.settings.arguments as Actividad;

    return Scaffold(
      appBar: AppBar(title: Text(act.titulo)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(act.imagen, height: 200, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text(
              act.descripcion,
              style: TextStyle(fontSize: 18),
            ),
            Divider(height: 32),
            Text('Materiales:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...act.materiales.map((m) => Text('• $m')).toList(),
            Divider(height: 32),
            Text('Instrucciones:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(act.instrucciones, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
