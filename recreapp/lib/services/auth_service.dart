// lib/services/auth_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  String? get currentUserId => supabase.auth.currentUser?.id;

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
    required String role, // 'student' | 'teacher'
  }) async {
    // Crea usuario (envía correo de confirmación si lo activaste en Supabase)
    final res = await supabase.auth.signUp(email: email, password: password);

    final userId = res.user?.id;
    if (userId != null) {
      // Guarda/actualiza perfil con nombre y rol
      await supabase.from('profiles').upsert({
        'id': userId,
        'full_name': fullName,
        'role': role,
      });
    }
    return res;
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    return supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() => supabase.auth.signOut();

  Future<bool> isTeacher() async {
    final uid = currentUserId;
    if (uid == null) return false;
    final data = await supabase
        .from('profiles')
        .select('role')
        .eq('id', uid)
        .maybeSingle();
    return (data?['role']?.toString() ?? '') == 'teacher';
  }
}
