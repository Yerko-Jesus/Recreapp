// lib/screens/teacher_dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../theme.dart';

class TeacherDashboardScreen extends StatefulWidget {
  static const String routeName = '/teacher-dashboard';
  const TeacherDashboardScreen({super.key});

  @override
  State<TeacherDashboardScreen> createState() =>
      _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  final _client = Supabase.instance.client;

  bool _loading = true;
  String? _error;

  int _positives = 0;
  int _negatives = 0;

  List<Map<String, dynamic>> _rows = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // 🔧 Sin genéricos en .select(); luego casteamos a List<Map<String, dynamic>>
      final data = await _client
          .from('feedback')
          .select('id, activity_title, category, is_positive, created_at')
          .order('created_at', ascending: false);

      final List<Map<String, dynamic>> rows =
      (data as List).cast<Map<String, dynamic>>();

      int pos = 0;
      int neg = 0;
      for (final r in rows) {
        final v = r['is_positive'];
        if (v == true) {
          pos++;
        } else if (v == false) {
          neg++;
        }
      }

      setState(() {
        _rows = rows;
        _positives = pos;
        _negatives = neg;
        _loading = false;
      });
    } on PostgrestException catch (e) {
      setState(() {
        _error =
        'PostgrestException(message: ${e.message}, code: ${e.code}, details: ${e
            .details}, hint: ${e.hint})';
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _shareSummary() async {
    final buffer = StringBuffer();
    buffer.writeln('Resumen de feedbacks');
    buffer.writeln('Positivos: $_positives, Negativos: $_negatives\n');
    for (final r in _rows) {
      final title = (r['activity_title'] ?? '').toString();
      final cat = (r['category'] ?? '').toString();
      final isPos = r['is_positive'] == true ? 'positive' : 'negative';
      final created = (r['created_at'] ?? '').toString();
      buffer.writeln('$created | $cat | $title | $isPos');
    }

    await SharePlus.instance.share(
      ShareParams(
        subject: 'Reporte de feedbacks',
        text: buffer.toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryPurple,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryPurple,
        title: const Text(
          'Panel Docente',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            tooltip: 'Compartir',
            onPressed: _rows.isEmpty ? null : _shareSummary,
            icon: const Icon(Icons.ios_share),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }
    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Error cargando datos: $_error',
          style: const TextStyle(color: Colors.white),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Text(
          'Resumen: $_positives positivos, $_negatives negativos',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        for (final r in _rows) _feedbackCard(r),
      ],
    );
  }

  Widget _feedbackCard(Map<String, dynamic> r) {
    final title = (r['activity_title'] ?? 'Actividad').toString();
    final cat = (r['category'] ?? '').toString();
    final isPos = r['is_positive'] == true;
    final createdIso = (r['created_at'] ?? '').toString();
    final created = DateTime.tryParse(createdIso);

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título en negro
            Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            if (cat.isNotEmpty)
              Text('#$cat', style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  isPos ? Icons.thumb_up : Icons.thumb_down,
                  size: 16,
                  color: isPos ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 6),
                const Text('·', style: TextStyle(color: Colors.black45)),
                const SizedBox(width: 6),
                Text(
                  isPos ? 'positive' : 'negative',
                  style: const TextStyle(color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              created != null ? created.toLocal().toString() : createdIso,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}