// lib/screens/student_report_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../theme.dart';

class StudentReportScreen extends StatefulWidget {
  final String userId;
  final String userName;

  const StudentReportScreen({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  State<StudentReportScreen> createState() => _StudentReportScreenState();
}

class _StudentReportScreenState extends State<StudentReportScreen> {
  final _client = Supabase.instance.client;

  bool _loading = true;
  String? _error;

  List<Map<String, dynamic>> _rows = [];
  int get _positives => _rows.where((r) => r['is_positive'] == true).length;
  int get _negatives => _rows.where((r) => r['is_positive'] == false).length;

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
      final data = await _client
          .from('feedback')
          .select('id, activity_title, category, is_positive, created_at')
          .eq('user_id', widget.userId)
          .order('created_at', ascending: false);

      final List<Map<String, dynamic>> rows =
      (data as List).cast<Map<String, dynamic>>();

      setState(() {
        _rows = rows;
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

  Future<void> _exportPdf() async {
    try {
      if (_rows.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No hay feedbacks para exportar.')),
        );
        return;
      }

      final doc = pw.Document();

      doc.addPage(
        pw.MultiPage(
          pageTheme: const pw.PageTheme(
            margin: pw.EdgeInsets.all(24),
          ),
          build: (context) {
            return [
              pw.Text(
                'Reporte de ${widget.userName}',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text('Generado: ${DateTime.now().toLocal()}'),
              pw.SizedBox(height: 12),
              pw.Text(
                'Resumen: ${_rows.length} registros · ${_positives} positivos · ${_negatives} negativos',
                style: const pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 12),
              pw.TableHelper.fromTextArray(
                headers: const ['Actividad', 'Categoría', 'Calificación', 'Fecha'],
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellStyle: const pw.TextStyle(fontSize: 10),
                cellAlignment: pw.Alignment.centerLeft,
                columnWidths: const {
                  0: pw.FlexColumnWidth(2.0),
                  1: pw.FlexColumnWidth(1.2),
                  2: pw.FlexColumnWidth(1.0),
                  3: pw.FlexColumnWidth(1.6),
                },
                data: _rows.map<List<String>>((r) {
                  final title = (r['activity_title'] ?? '').toString();
                  final cat = (r['category'] ?? '').toString();
                  final isPos = r['is_positive'] == true ? 'positive' : 'negative';
                  final created = (r['created_at'] ?? '').toString();
                  return [title, cat, isPos, created];
                }).toList(),
              ),
            ];
          },
        ),
      );

      await Printing.sharePdf(
        bytes: await doc.save(),
        filename: 'reporte_${widget.userName}.pdf',
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creando PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryPurple,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryPurple,
        title: Text(
          widget.userName,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            tooltip: 'Exportar PDF',
            onPressed: _rows.isEmpty ? null : _exportPdf,
            icon: const Icon(Icons.picture_as_pdf_outlined),
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

    if (_rows.isEmpty) {
      return const Center(
        child: Text(
          'Este alumno aún no tiene feedbacks.',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Text(
          'Resumen: ${_positives} positivos · ${_negatives} negativos · total ${_rows.length}',
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
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
