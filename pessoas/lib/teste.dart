import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'package:pessoas/utils/mobile.dart';

class Teste extends StatelessWidget {
  const Teste({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _createPDF,
          child: Text('Create PDF'),
        ),
      ),
    );
  }
}

Future<void> _createPDF() async {
  PdfDocument document = PdfDocument();
  final page = document.pages.add();

  page.graphics.drawString('Welcome to PDF Succinctly',
      PdfStandardFont(PdfFontFamily.helvetica, 30));

  List<int> bytes = await document.save();
  document.dispose();

  saveAndLauchFile(bytes, 'Output.pdf');
}
