// lib/screens/activity_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/actividad.dart';
import '../theme.dart';
import 'categories_screen.dart';

class ActivityScreen extends StatelessWidget {
  static const String routeName = '/activity';

  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final actividad = ModalRoute.of(context)!.settings.arguments as Actividad;

    return Scaffold(
      backgroundColor: AppTheme.primaryPurple,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          actividad.titulo,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                actividad.imagen,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Descripción
            const Text(
              'Descripción',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              actividad.descripcion,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),

            const SizedBox(height: 16),
            const Divider(color: Colors.white24),

            // Materiales
            const SizedBox(height: 8),
            const Text(
              'Materiales',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 6),
            ...actividad.materiales.map(
                  (m) => Text('• $m',
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
            ),

            const SizedBox(height: 16),
            const Divider(color: Colors.white24),

            // Pasos
            const SizedBox(height: 8),
            const Text(
              'Pasos',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              actividad.pasos,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),

            const SizedBox(height: 24),

            // Botón Feedback
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final rating = await _showFeedbackDialog(context);
                  if (rating == null) return; // cancelado

                  final user = Supabase.instance.client.auth.currentUser;
                  if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Inicia sesión para enviar feedback.'),
                      ),
                    );
                    return;
                  }

                  try {
                    await Supabase.instance.client.from('feedbacks').insert({
                      'user_id': user.id,
                      'activity_id': actividad.id,
                      'rating': rating, // 'positive' | 'negative'
                    });

                    // Aviso
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('¡Gracias por tu feedback!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );

                    // Volver a categorías limpiando el stack
                    // (así no “queda atrapado”)
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      CategoriesScreen.routeName,
                          (r) => false,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error al guardar feedback: $e'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black, // texto negro como pediste
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Dar feedback'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Muestra diálogo con dos opciones iguales visualmente.
  Future<String?> _showFeedbackDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('¿Cómo te fue?'),
          content: const Text(
            'Cuéntanos si te gustó o no esta actividad.',
          ),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          actions: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop('positive'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      minimumSize: const Size.fromHeight(44),
                    ),
                    child: const Text('Me gustó'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop('negative'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      minimumSize: const Size.fromHeight(44),
                    ),
                    child: const Text('No me gustó'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
