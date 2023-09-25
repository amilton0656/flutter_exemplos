import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_full_pdf_viewer_null_safe/flutter_full_pdf_viewer.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../models/models.dart';

class UsuarioListaPdf extends StatelessWidget {
  final List<UsuarioModel>? usuarios;
  const UsuarioListaPdf({
    super.key,
    this.usuarios = const [],
  });

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
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(build: (context) {
        return [
          pw.ListView.builder(
            itemCount: usuarios!.length,
            itemBuilder: (ctx, index) => pw.SizedBox(
                height: 30,
                child: pw.Row(children: [
                  pw.Container(
                    height: 25,
                    width: 50,
                    child: pw.Text(usuarios![index].id.toString()),
                  ),
                  pw.Container(
                    height: 25,
                    width: 200,
                    child: pw.Text(usuarios![index].nome),
                  ),
                  pw.Container(
                    height: 25,
                    width: 200,
                    child: pw.Text(usuarios![index].email),
                  ),
                ])),
          )
        ];
      }),
    );

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
