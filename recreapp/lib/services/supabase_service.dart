// lib/services/supabase_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  Future<void> saveFeedback({
    required String activityTitle,
    String? category,
    required bool liked,
  }) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('No hay sesión iniciada');
    }

    await supabase.from('feedbacks').insert({
      'user_id': userId,
      'activity_title': activityTitle,
      'category': category,
      'liked': liked,
    });
  }
}
