// lib/screens/feedback_screen.dart
import 'package:flutter/material.dart';
import '../theme.dart';
import 'categories_screen.dart';
import '../services/supabase_service.dart';

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
    final liked = valor == 'positive';
    try {
      await SupabaseService().saveFeedback(
        activityTitle: actividadTitulo ?? 'Actividad',
        category: null, // pásame la categoría si la tienes
        liked: liked,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Inicia sesión para enviar feedback. $e'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
        Text('Gracias por tu feedback: ${liked ? 'Me gustó' : 'No me gustó'}'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 900),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 950));
    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
        context, CategoriesScreen.routeName, (route) => route.isFirst);
  }

  ButtonStyle _btnStyle() {
    return ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 52),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    final titulo = actividadTitulo ?? 'Actividad';
    return Scaffold(
      backgroundColor: AppTheme.primaryPurple,
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
