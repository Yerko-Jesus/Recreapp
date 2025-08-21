// lib/screens/feedback_screen.dart
import 'package:flutter/material.dart';
import '../theme.dart';
import 'categories_screen.dart';

class FeedbackScreen extends StatefulWidget {
  static const String routeName = '/feedback';

  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String? actividadTitulo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is Map) {
      actividadTitulo = args['actividadTitulo']?.toString();
    }
  }

  Future<void> _enviar(String valor) async {
    // Aquí podrías guardar en BD/Firestore si ya lo tienes listo.
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Gracias por tu feedback: ${valor == 'positive' ? 'Me gustó' : 'No me gustó'}'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 900),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 950));
    if (!mounted) return;

    // Volvemos a categorías y limpiamos el stack hasta allí
    Navigator.pushNamedAndRemoveUntil(context, CategoriesScreen.routeName, (route) => route.isFirst);
  }

  ButtonStyle _btnStyle() {
    return ButtonStyle(
      minimumSize: WidgetStateProperty.all(const Size(double.infinity, 52)),
      backgroundColor: WidgetStateProperty.all(Colors.white),
      foregroundColor: WidgetStateProperty.all(Colors.black),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      elevation: WidgetStateProperty.all(2),
      overlayColor: WidgetStateProperty.all(Colors.black12),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titulo = actividadTitulo ?? 'Actividad';
    return Scaffold(
      backgroundColor: AppTheme.primaryPurple, // fondo morado
      appBar: AppBar(
        backgroundColor: AppTheme.primaryPurple,
        title: Text(
          'Feedback — $titulo',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            const Text(
              '¿Te gustó esta actividad?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Me gustó
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _enviar('positive'),
                style: _btnStyle(),
                icon: const Icon(Icons.thumb_up_alt_outlined),
                label: const Text('Me gustó'),
              ),
            ),

            const SizedBox(height: 12),

            // No me gustó
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _enviar('negative'),
                style: _btnStyle(),
                icon: const Icon(Icons.thumb_down_alt_outlined),
                label: const Text('No me gustó'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
