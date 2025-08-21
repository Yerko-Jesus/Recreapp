// lib/screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../theme.dart';
import '../services/auth_service.dart';
import 'categories_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String _role = 'student';
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _doRegister() async {
    if (!_form.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await AuthService().signUp(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text,
        fullName: _nameCtrl.text.trim(),
        role: _role,
      );
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, CategoriesScreen.routeName);
    } on AuthException catch (e) {
      setState(() => _error = e.message);
    } catch (e) {
      setState(() => _error = 'Error desconocido: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  InputDecoration _dec(String label) => InputDecoration(labelText: label);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryPurple, // fondo morado
      appBar: AppBar(
        title: const Text('Crear cuenta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameCtrl,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: _dec('Nombre completo'),
                validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Ingresa tu nombre' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: _dec('Correo electrónico'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Ingresa tu correo';
                  final ok = RegExp(r'^\S+@\S+\.\S+$').hasMatch(v.trim());
                  if (!ok) return 'Correo inválido';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passCtrl,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: _dec('Contraseña'),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Ingresa una contraseña';
                  if (v.length < 6) return 'Mínimo 6 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Perfil', style: TextStyle(color: Colors.white)),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      value: 'student',
                      groupValue: _role,
                      onChanged: (v) => setState(() => _role = v!),
                      title: const Text('Alumno',
                          style: TextStyle(color: Colors.white)),
                      fillColor: WidgetStateProperty.all(Colors.white),
                      activeColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      value: 'teacher',
                      groupValue: _role,
                      onChanged: (v) => setState(() => _role = v!),
                      title: const Text('Docente',
                          style: TextStyle(color: Colors.white)),
                      fillColor: WidgetStateProperty.all(Colors.white),
                      activeColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.orangeAccent)),
              const SizedBox(height: 8),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _loading ? null : _doRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text('Crear cuenta'),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _loading
                    ? null
                    : () => Navigator.pushReplacementNamed(
                  context,
                  LoginScreen.routeName,
                ),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, // enlace en blanco
                ),
                child: const Text('Ya tengo cuenta'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
