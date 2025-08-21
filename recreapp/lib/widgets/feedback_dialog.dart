// lib/widgets/feedback_dialog.dart
import 'package:flutter/material.dart';
import '../models/actividad.dart';

class FeedbackDialog extends StatefulWidget {
  final Actividad actividad;
  const FeedbackDialog({required this.actividad, super.key});

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.actividad.titulo),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Antes usaba "instrucciones"; ahora es "pasos"
            Text(widget.actividad.pasos),
            const SizedBox(height: 16),
            const Text(
              'Materiales:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            for (final m in widget.actividad.materiales)
              Text('• $m', style: const TextStyle(fontSize: 14)),

            const Divider(height: 24),
            const Text(
              '¿Cómo te fue?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _feedbackButton(
                  label: 'Me gustó',
                  icon: Icons.sentiment_satisfied_alt,
                  value: 'positive',
                ),
                _feedbackButton(
                  label: 'No me gustó',
                  icon: Icons.sentiment_dissatisfied,
                  value: 'negative',
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // cierra sin respuesta
          child: const Text('Cerrar'),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }

  Widget _feedbackButton({
    required String label,
    required IconData icon,
    required String value,
  }) {
    // Botones iguales, sin "selección" persistente (no quedan sombreados)
    return ElevatedButton.icon(
      onPressed: () => Navigator.of(context).pop(value),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
