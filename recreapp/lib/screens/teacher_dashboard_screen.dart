// lib/screens/teacher_dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pdf/pdf.dart' as pdf; // Para PdfColor
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../theme.dart';

class TeacherDashboardScreen extends StatefulWidget {
  static const String routeName = '/teacher-dashboard';
  const TeacherDashboardScreen({super.key});

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  final _client = Supabase.instance.client;

  bool _loading = true;
  String? _error;

  int _positives = 0;
  int _negatives = 0;

  /// Todos los feedbacks (para PDF general). Cada fila puede traer `users:{full_name,email}`
  List<Map<String, dynamic>> _rows = [];

  /// idUsuario -> {name, email}
  final Map<String, Map<String, dynamic>> _userById = {};

  /// Lista de alumnos únicos con feedback [{id,name,email}]
  List<Map<String, dynamic>> _students = [];

  /// Conteo por alumno
  final Map<String, int> _countByUser = {};

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
      dynamic data;

      // 1) Intentamos con el nombre de FK más probable
      try {
        data = await _client
            .from('feedback')
            .select(
          'user_id, activity_title, category, is_positive, created_at, users:users!feedback_user_fk (id, email, full_name)',
        )
            .order('created_at', ascending: false);
      } on PostgrestException catch (e) {
        final msg = (e.message ?? '');
        // 2) Si hay conflicto de relaciones, probamos con el otro nombre
        if (e.code == 'PGRST201' || msg.contains('more than one relationship')) {
          data = await _client
              .from('feedback')
              .select(
            'user_id, activity_title, category, is_positive, created_at, users:users!feedback_user_fk (id, email, full_name)',
          )
              .order('created_at', ascending: false);
        } else {
          rethrow;
        }
      }

      final rows = (data as List).cast<Map<String, dynamic>>();

      int pos = 0, neg = 0;
      final Map<String, Map<String, dynamic>> userById = {};
      final Map<String, int> countByUser = {};
      final List<Map<String, dynamic>> students = [];
      final seen = <String>{};

      for (final r in rows) {
        final uid = (r['user_id'] ?? '').toString();
        final userObj = (r['users'] as Map?)?.cast<String, dynamic>();
        final fullName = (userObj?['full_name'] ?? '(sin nombre)').toString();
        final email = (userObj?['email'] ?? '').toString();

        if (uid.isNotEmpty) {
          countByUser.update(uid, (v) => v + 1, ifAbsent: () => 1);
          userById[uid] = {'name': fullName, 'email': email};
          if (!seen.contains(uid)) {
            seen.add(uid);
            students.add({'id': uid, 'name': fullName, 'email': email});
          }
        }

        final v = r['is_positive'];
        if (v == true) pos++;
        if (v == false) neg++;
      }

      setState(() {
        _rows = rows;
        _positives = pos;
        _negatives = neg;
        _userById
          ..clear()
          ..addAll(userById);
        _students = students;
        _countByUser
          ..clear()
          ..addAll(countByUser);
        _loading = false;
      });
    } on PostgrestException catch (e) {
      setState(() {
        _error =
        'PostgrestException(message: ${e.message}, code: ${e.code}, details: ${e.details}, hint: ${e.hint})';
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }


  // ====== PDF: General ======
  Future<void> _exportPdfGeneral() async {
    final doc = pw.Document();

    final headerStyle =
    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold);
    final normal = pw.TextStyle(fontSize: 12);

    doc.addPage(
      pw.MultiPage(
        build: (ctx) => [
          pw.Text('Reporte general de feedbacks', style: headerStyle),
          pw.SizedBox(height: 6),
          pw.Text('Positivos: $_positives  |  Negativos: $_negatives',
              style: normal),
          pw.SizedBox(height: 14),

          // Tabla con nombre del niño incluido
          pw.TableHelper.fromTextArray(
            headers: const [
              'Fecha',
              'Niño',
              'Categoría',
              'Actividad',
              'Feedback'
            ],
            data: _rows.map((r) {
              final createdIso = (r['created_at'] ?? '').toString();
              final date = DateTime.tryParse(createdIso)
                  ?.toLocal()
                  .toString() ??
                  createdIso;
              final uid = (r['user_id'] ?? '').toString();
              final fallbackName =
              ((r['users'] as Map?)?['full_name'] ?? '(sin nombre)')
                  .toString();
              final name =
              (_userById[uid]?['name'] ?? fallbackName).toString();
              final cat = (r['category'] ?? '').toString();
              final title = (r['activity_title'] ?? '').toString();
              final fb = r['is_positive'] == true ? 'positive' : 'negative';
              return [date, name, cat, title, fb];
            }).toList(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellStyle: pw.TextStyle(fontSize: 10),
            headerDecoration:
            pw.BoxDecoration(color: pdf.PdfColor.fromInt(0xFFEFEFEF)),
            cellAlignment: pw.Alignment.centerLeft,
            columnWidths: {
              0: pw.FlexColumnWidth(2), // fecha
              1: pw.FlexColumnWidth(2), // niño
              2: pw.FlexColumnWidth(2), // categoría
              3: pw.FlexColumnWidth(3), // actividad
              4: pw.FlexColumnWidth(1), // feedback
            },
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => doc.save(),
      name: 'reporte_general_feedbacks.pdf',
    );
  }

  // ====== PDF: por alumno ======
  Future<void> _exportPdfAlumno({
    required String userId,
    required String name,
    required List<Map<String, dynamic>> rows,
  }) async {
    final doc = pw.Document();

    final headerStyle =
    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold);
    final normal = pw.TextStyle(fontSize: 12);

    final positivos = rows.where((r) => r['is_positive'] == true).length;
    final negativos = rows.where((r) => r['is_positive'] == false).length;

    doc.addPage(
      pw.MultiPage(
        build: (ctx) => [
          pw.Text('Reporte de $name', style: headerStyle),
          pw.SizedBox(height: 6),
          pw.Text('Positivos: $positivos  |  Negativos: $negativos',
              style: normal),
          pw.SizedBox(height: 14),

          pw.TableHelper.fromTextArray(
            headers: const ['Fecha', 'Categoría', 'Actividad', 'Feedback'],
            data: rows.map((r) {
              final createdIso = (r['created_at'] ?? '').toString();
              final date = DateTime.tryParse(createdIso)
                  ?.toLocal()
                  .toString() ??
                  createdIso;
              final cat = (r['category'] ?? '').toString();
              final title = (r['activity_title'] ?? '').toString();
              final fb = r['is_positive'] == true ? 'positive' : 'negative';
              return [date, cat, title, fb];
            }).toList(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellStyle: pw.TextStyle(fontSize: 10),
            headerDecoration:
            pw.BoxDecoration(color: pdf.PdfColor.fromInt(0xFFEFEFEF)),
            cellAlignment: pw.Alignment.centerLeft,
            columnWidths: {
              0: pw.FlexColumnWidth(2),
              1: pw.FlexColumnWidth(2),
              2: pw.FlexColumnWidth(3),
              3: pw.FlexColumnWidth(1),
            },
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => doc.save(),
      name: 'reporte_$name.pdf',
    );
  }

  Future<void> _openStudentDetail(String userId) async {
    // Traer feedbacks del alumno (no necesitamos embed aquí)
    final data = await _client
        .from('feedback')
        .select('activity_title, category, is_positive, created_at')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    final rows = (data as List).cast<Map<String, dynamic>>();
    final name = (_userById[userId]?['name'] ?? '(sin nombre)').toString();
    final email = (_userById[userId]?['email'] ?? '').toString();

    final pos = rows.where((r) => r['is_positive'] == true).length;
    final neg = rows.where((r) => r['is_positive'] == false).length;

    if (!mounted) return;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                if (email.isNotEmpty)
                  Text(email, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 8),
                Text('Resumen: $pos positivos, $neg negativos'),
                const SizedBox(height: 8),
                SizedBox(
                  height: 260,
                  child: rows.isEmpty
                      ? const Center(child: Text('Sin feedbacks aún'))
                      : ListView.builder(
                    itemCount: rows.length,
                    itemBuilder: (ctx, i) {
                      final r = rows[i];
                      final title =
                      (r['activity_title'] ?? '').toString();
                      final cat = (r['category'] ?? '').toString();
                      final isPos = r['is_positive'] == true;
                      final createdIso =
                      (r['created_at'] ?? '').toString();
                      final created =
                      DateTime.tryParse(createdIso)?.toLocal();

                      return ListTile(
                        dense: true,
                        leading: Icon(
                          isPos ? Icons.thumb_up : Icons.thumb_down,
                          color: isPos ? Colors.green : Colors.red,
                        ),
                        title: Text(title),
                        subtitle: Text(
                          '#$cat · ${created != null ? created.toString() : createdIso}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: rows.isEmpty
                        ? null
                        : () => _exportPdfAlumno(
                      userId: userId,
                      name: name,
                      rows: rows,
                    ),
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Exportar PDF del alumno'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
            tooltip: 'Exportar PDF general',
            onPressed: _rows.isEmpty ? null : _exportPdfGeneral,
            icon: const Icon(Icons.picture_as_pdf),
          ),
          IconButton(
            tooltip: 'Recargar',
            onPressed: _loadData,
            icon: const Icon(Icons.refresh),
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
          'Error: $_error',
          style: const TextStyle(color: Colors.white),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Resumen general: $_positives positivos, $_negatives negativos',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        if (_students.isEmpty)
          const Text(
            'Aún no hay feedbacks de alumnos.',
            style: TextStyle(color: Colors.white70),
          )
        else
          ..._students.map((u) {
            final uid = u['id'] as String;
            final name = (u['name'] ?? '(sin nombre)').toString();
            final email = (u['email'] ?? '').toString();
            final count = _countByUser[uid] ?? 0;
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text(name,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(email.isEmpty ? ' ' : email, maxLines: 1),
                trailing: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.deepPurple.shade100,
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () => _openStudentDetail(uid),
              ),
            );
          }),
      ],
    );
  }
}
