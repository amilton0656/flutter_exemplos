import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_full_pdf_viewer_null_safe/flutter_full_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as p;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class Pdf3 extends StatefulWidget {
  const Pdf3({super.key});

  @override
  State<Pdf3> createState() => _Pdf3State();
}

class _Pdf3State extends State<Pdf3> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(),
      ),
    );
  }

  Future<Uint8List> makePdf() async {
    final pdf = p.Document();

    pdf.addPage(p.Page(build: (context) {
      return p.Center(
          child: p.Column(children: [
        p.Text('Amilton'),
        p.Text('Teste de garacao de pdf'),
      ]));
    }));

    return pdf.save();
  }
}

class MostraPdf extends StatelessWidget {
  final String path;
  const MostraPdf({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      path: path,
    );
  }
}
