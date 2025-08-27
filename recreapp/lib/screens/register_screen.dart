// lib/screens/register_screen.dart
import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  DateTime? _dob;
  String _role = 'student'; // 'student' | 'teacher'
  bool _loading = false;

  // Usa el singleton
  final _auth = AuthService.instance;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 8, 1, 1),
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(now.year - 5, 12, 31),
      helpText: 'Fecha de nacimiento',
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
      builder: (ctx, child) {
        // Tema claro sobre fondo morado
        return Theme(
          data: Theme.of(ctx).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.white,
              surface: Colors.deepPurple,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _dob = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_dob == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona la fecha de nacimiento')),
      );
      return;
    }

    setState(() => _loading = true);
    try {
      await _auth.signUp(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text,
        fullName: _nameCtrl.text.trim(),
        dateOfBirth: _dob!,
        role: _role,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso. Revisa tu correo para confirmar.')),
      );
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar: $e')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  InputDecoration _decor(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: Colors.white),
      hintStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.transparent,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white70),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryPurple,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryPurple,
        elevation: 0,
        title: const Text('Crear cuenta', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameCtrl,
                  style: const TextStyle(color: Colors.white),
                  decoration: _decor('Nombre completo', 'Ej: Ana Pérez'),
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Ingresa tu nombre' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailCtrl,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  decoration: _decor('Correo', 'tucorreo@ejemplo.com'),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Ingresa tu correo';
                    if (!v.contains('@')) return 'Correo inválido';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passCtrl,
                  style: const TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: _decor('Contraseña', 'Mínimo 6 caracteres'),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Ingresa una contraseña';
                    if (v.length < 6) return 'Mínimo 6 caracteres';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _pickDate,
                  child: AbsorbPointer(
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      decoration: _decor(
                        'Fecha de nacimiento',
                        _dob == null
                            ? 'Selecciona una fecha'
                            : '${_dob!.day.toString().padLeft(2, '0')}-'
                            '${_dob!.month.toString().padLeft(2, '0')}-'
                            '${_dob!.year}',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ======= Selección de rol sin radios (evita deprecaciones) =======
                DropdownButtonFormField<String>(
                  value: _role,
                  items: const [
                    DropdownMenuItem(
                      value: 'student',
                      child: Text('Estudiante', style: TextStyle(color: Colors.white)),
                    ),
                    DropdownMenuItem(
                      value: 'teacher',
                      child: Text('Docente', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                  onChanged: (v) => setState(() => _role = v ?? 'student'),
                  decoration: _decor('Rol', 'Selecciona tu rol'),
                  dropdownColor: AppTheme.primaryPurple,
                  iconEnabledColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 24),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _submit,
                    child: _loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Crear cuenta', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: _loading
                      ? null
                      : () => Navigator.pushReplacementNamed(context, LoginScreen.routeName),
                  child: const Text(
                    'Ya tengo cuenta',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
