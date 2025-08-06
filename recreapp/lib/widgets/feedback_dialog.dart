// lib/widgets/feedback_dialog.dart
import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/actividad.dart';

class FeedbackDialog extends StatefulWidget {
  final Actividad actividad;
  const FeedbackDialog({required this.actividad, super.key});

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  String? _rating; // 'positive' o 'negative'

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.actividad.titulo),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.actividad.instrucciones),
            const SizedBox(height: 16),
            const Text('Materiales:', style: TextStyle(fontWeight: FontWeight.bold)),
            for (var m in widget.actividad.materiales)
              Text('• $m', style: const TextStyle(fontSize: 14)),
            const Divider(height: 32),
            const Text('¿Cómo te fue?', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _smileyButton('positive', Icons.sentiment_satisfied_alt),
                _smileyButton('negative', Icons.sentiment_dissatisfied),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // cierra sin rating
          child: const Text('Cerrar'),
        ),
      ],
    );
  }

  Widget _smileyButton(String value, IconData icon) {
    final selected = _rating == value;
    return IconButton(
      iconSize: selected ? 40 : 30,
      icon: Icon(icon, color: selected ? AppTheme.accentRed : Colors.grey),
      onPressed: () {
        Navigator.of(context).pop(value); // devuelve 'positive' o 'negative'
      },
    );
  }
}

