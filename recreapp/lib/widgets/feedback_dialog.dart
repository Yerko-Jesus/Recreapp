// lib/widgets/feedback_dialog.dart
import 'package:flutter/material.dart';

class FeedbackDialog extends StatelessWidget {
  const FeedbackDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        '¿Te gustó la actividad?',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: const Text('Elige una opción'),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        // Me gustó
        ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.sentiment_satisfied_alt),
          label: const Text('Me gustó'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            side: const BorderSide(color: Colors.black87),
          ),
        ),
        // No me gustó
        ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(false),
          icon: const Icon(Icons.sentiment_dissatisfied),
          label: const Text('No me gustó'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            side: const BorderSide(color: Colors.black87),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
