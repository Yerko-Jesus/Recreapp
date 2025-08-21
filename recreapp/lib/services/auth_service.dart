// lib/services/auth_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String role, // 'student' | 'teacher'
    required DateTime dateOfBirth,
  }) async {
    // 1) Crear usuario de Auth (puedes guardar metadata si quieres)
    final res = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': fullName,
        'role': role,
        'date_of_birth': _fmt(dateOfBirth),
      },
    );

    final user = res.user;
    if (user == null) {
      throw AuthException('No se pudo crear el usuario');
    }

    // 2) Upsert en tabla 'users' (id = auth.users.id)
    await _supabase.from('users').upsert({
      'id': user.id,
      'email': email,
      'full_name': fullName,
      'role': role,
      'date_of_birth': _fmt(dateOfBirth),
    });
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  String _fmt(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
