// lib/screens/activity_screen.dart
import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/actividad.dart';
import 'feedback_screen.dart';

class ActivityScreen extends StatelessWidget {
  static const String routeName = '/actividad';

  const ActivityScreen({super.key});

  List<String> _extraerPasos(String instrucciones) {
    final raw = instrucciones.trim();
    if (raw.isEmpty) return const [];
    // 1) dividir por líneas
    final porLineas = raw
        .split(RegExp(r'\r?\n'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    if (porLineas.length > 1) return porLineas;
    // 2) dividir por viñetas (•, -, –)
    final porVinetas = raw
        .split(RegExp(r'(?:^|\n|\r)[\s]*[•\-–]\s+'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    if (porVinetas.length > 1) return porVinetas;
    return const [];
  }

  @override
  Widget build(BuildContext context) {
    final act = ModalRoute.of(context)!.settings.arguments as Actividad;

    final List<String> pasos = _extraerPasos(act.instrucciones);

    return Scaffold(
      backgroundColor: AppTheme.primaryPurple,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryPurple,
        title: Text(
          act.titulo,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                act.imagen,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Descripción
            if (act.descripcion.trim().isNotEmpty) ...[
              const Text(
                'Descripción',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                act.descripcion,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],

            // Materiales
            if (act.materiales.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Materiales',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              for (final m in act.materiales)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $m', style: const TextStyle(color: Colors.white)),
                ),
            ],

            // Pasos (derivados de instrucciones) o instrucciones como texto
            if (pasos.isNotEmpty || act.instrucciones.trim().isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Pasos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              if (pasos.isNotEmpty)
                ...pasos.map(
                      (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text('• $p', style: const TextStyle(color: Colors.white)),
                  ),
                ),
              if (pasos.isEmpty)
                Text(
                  act.instrucciones,
                  style: const TextStyle(color: Colors.white),
                ),
            ],

            const SizedBox(height: 100), // espacio para el botón fijo
          ],
        ),
      ),

      // BOTÓN FIJO: "Dar feedback"
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  FeedbackScreen.routeName,
                  arguments: {'actividadTitulo': act.titulo},
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white),
                foregroundColor: WidgetStateProperty.all(Colors.black),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                elevation: WidgetStateProperty.all(2),
                overlayColor: WidgetStateProperty.all(Colors.black12),
              ),
              icon: const Icon(Icons.thumb_up_alt_outlined),
              label: const Text(
                'Dar feedback',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
