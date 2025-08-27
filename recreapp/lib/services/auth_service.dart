// lib/services/auth_service.dart
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  final SupabaseClient _sb = Supabase.instance.client;

  Session? get session => _sb.auth.currentSession;
  User? get user => _sb.auth.currentUser;

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
    required DateTime dateOfBirth,
    required String role, // 'student' | 'teacher'
  }) async {
    final dobIso = dateOfBirth.toIso8601String().substring(0, 10); // YYYY-MM-DD
    try {
      final resp = await _sb.auth.signUp(
        email: email,
        password: password,
        data: <String, dynamic>{
          'full_name': fullName,
          'date_of_birth': dobIso,
          'role': role,
        },
      );
      debugPrint('AUTH signUp -> user=${resp.user?.id} email=${resp.user?.email} session=${resp.session != null}');
      if (resp.user == null) {
        throw AuthException('El registro no devolvió usuario. Revisa URL/anonKey del proyecto.');
      }
      return resp;
    } on AuthException catch (e) {
      debugPrint('AuthException signUp: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Unknown error signUp: $e');
      rethrow;
    }
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final resp = await _sb.auth.signInWithPassword(email: email, password: password);
      debugPrint('AUTH signIn -> user=${resp.user?.id} session=${resp.session != null}');
      return resp;
    } on AuthException catch (e) {
      debugPrint('AuthException signIn: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Unknown error signIn: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _sb.auth.signOut();
    debugPrint('AUTH signOut ok');
  }
}
