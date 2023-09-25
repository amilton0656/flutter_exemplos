import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer_null_safe/full_pdf_viewer_scaffold.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:share_extend/share_extend.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'pdf_api.dart';

class PdfTeste extends StatefulWidget {
  const PdfTeste({super.key});

  @override
  State<PdfTeste> createState() => _PdfTesteState();
}

class _PdfTesteState extends State<PdfTeste> {
  Future<void> teste01() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          ); // Center
        }));

    final file = File('example.pdf');
    await file.writeAsBytes(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final pdfFile = await PdfApi.generateCenteredText('Sample Text');
            PdfApi.openFile(pdfFile);
          },
          child: const Text("Pdf"),
        ),
      ),
    );
  }

  _createPdf(BuildContext context, name, lastName, year) async {
    final pdfLib.Document pdf = pdfLib.Document(deflate: zlib.encode);

    try {
      pdf.addPage(
        pdfLib.MultiPage(
            build: (context) => [
                  pdfLib.TableHelper.fromTextArray(data: <List<String>>[
                    <String>['Nome', 'Sobrenome', 'Idade'],
                    ['Amilton', 'Rocha', '1956']
                  ])
                ]),
      );
    } catch (err) {}

    final String dir = (await getApplicationDocumentsDirectory()).path;

    final String path = '$dir/pdfExemplo.pdf';

    final File file = File(path);

    file.writeAsBytesSync(await pdf.save());
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PdfScreen(pathPdf: path)));
  }
}

class PdfScreen extends StatelessWidget {
  const PdfScreen({super.key, required this.pathPdf});

  final String pathPdf;

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: const Text('Document'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share))
          ],
        ),
        path: pathPdf);
  }
}
