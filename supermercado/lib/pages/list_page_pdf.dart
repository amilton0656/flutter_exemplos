import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_full_pdf_viewer_null_safe/flutter_full_pdf_viewer.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:supermercado/item_model.dart';

class ItemsListaPdf extends StatelessWidget {
  final List<ItemModel>? items;
  final String usuario;
  const ItemsListaPdf(
      {super.key, this.items = const [], required this.usuario});

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
          pw.Column(children: [
            pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 20),
              child: pw.Center(
                child: pw.Text(
                  usuario,
                  style: const pw.TextStyle(fontSize: 20),
                ),
              ),
            ),
            pw.ListView.builder(
              itemCount: items!.length,
              itemBuilder: (ctx, index) => pw.SizedBox(
                  height: 30,
                  child: pw.Row(children: [
                    pw.Container(
                      height: 25,
                      width: 50,
                      child: pw.Text(items![index].quantidade),
                    ),
                    pw.Container(
                      height: 25,
                      width: 200,
                      child: pw.Text(items![index].descricao),
                    ),
                    pw.Container(
                      height: 25,
                      width: 200,
                      child: pw.Text(items![index].grupo),
                    ),
                  ])),
            )
          ])
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
