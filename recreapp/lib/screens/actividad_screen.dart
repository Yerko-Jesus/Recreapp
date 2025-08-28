// lib/screens/actividad_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/actividad.dart';
import '../theme.dart';
import '../widgets/feedback_dialog.dart';

class ActividadScreen extends StatelessWidget {
  static const String routeName = '/actividad';
  const ActividadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final act = ModalRoute.of(context)!.settings.arguments as Actividad;

    final materiales = _toList(act.materiales);
    final pasos = _toList(act.pasos);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          act.titulo,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: AppTheme.primaryPurple, // fondo morado
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                act.imagen,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Descripción
            Text(
              act.descripcion,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 16),

            // Materiales
            const Text(
              'Materiales',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            ...materiales.map(
                  (m) => Text('• $m', style: const TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16),

            // Pasos
            const Text(
              'Pasos',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            for (var i = 0; i < pasos.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  '${i + 1}. ${pasos[i]}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            const SizedBox(height: 28),

            // Botón feedback
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final result = await showDialog<bool>(
                    context: context,
                    builder: (_) => const FeedbackDialog(),
                  );
                  if (result == null) return; // canceló
                  await _guardarFeedback(context, act, result);
                },
                icon: const Icon(Icons.rate_review),
                label: const Text('Evaluar actividad'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Adapta string/lista a List<String>
  static List<String> _toList(dynamic value) {
    if (value == null) return const <String>[];
    if (value is List<String>) return value;
    if (value is List) {
      return value.map((e) => '$e').toList();
    }
    final s = value.toString();
    if (s.contains('\n')) {
      return s.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    if (s.contains('•')) {
      return s.split('•').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    return [s];
  }

  Future<void> _guardarFeedback(
      BuildContext context,
      Actividad act,
      bool isPositive,
      ) async {
    final supa = Supabase.instance.client;
    final user = supa.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes iniciar sesión para evaluar.')),
      );
      return;
    }

    try {
      await supa.from('feedback').insert({
        'user_id': user.id,
        'activity_id': act.id,
        'activity_title': act.titulo,
        'category': act.categoria, // <- asegúrate que existe en la tabla
        'is_positive': isPositive,
        'created_at': DateTime.now().toUtc().toIso8601String(),
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isPositive ? '¡Gracias por tu evaluación!' : 'Gracias por tu evaluación.',
            ),
          ),
        );
        Navigator.of(context).pop(); // volver a la lista
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error guardando feedback: $e')),
        );
      }
    }
  }
}
