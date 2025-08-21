// lib/screens/actividad_screen.dart
import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/actividad.dart';
import 'feedback_screen.dart';

class ActividadScreen extends StatelessWidget {
  static const String routeName = '/actividad';
  const ActividadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final act = ModalRoute.of(context)!.settings.arguments as Actividad;

    return Scaffold(
      backgroundColor: AppTheme.primaryPurple,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryPurple,
        title: Text(
          act.titulo,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                act.imagen,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              act.descripcion,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'Materiales:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            for (final m in act.materiales)
              Text('• $m', style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 16),
            const Text(
              'Pasos:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              act.pasos, // <- ahora existe en el modelo
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    FeedbackScreen.routeName,
                    arguments: {'actividadTitulo': act.titulo},
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.feedback_outlined),
                label: const Text('Dar feedback'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
