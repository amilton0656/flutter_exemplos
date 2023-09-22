import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

Future<Uint8List> generatedPdf(final PdfPageFormat format) async {
  final doc = pw.Document(
    title: 'Flutter School',
  );

  final logoImage = pw.MemoryImage(
    (await rootBundle.load('assets/images/flutter_school.png'))
        .buffer
        .asUint8List(),
  );

  final footerImage = pw.MemoryImage(
    (await rootBundle.load('assets/images/footer.png')).buffer.asUint8List(),
  );

  final font = await rootBundle.load('assets/fonts/Raleway-Regular.ttf');
  final ttf = pw.Font.ttf(font);

  final pageTheme = await _myPageTheme(format);

  doc.addPage(pw.MultiPage(
      pageTheme: pageTheme,
      header: (final context) => pw.Image(
            alignment: pw.Alignment.topLeft,
            logoImage,
            fit: pw.BoxFit.contain,
            width: 180,
          ),
      footer: (final context) => pw.Image(
            footerImage,
            fit: pw.BoxFit.scaleDown,
          ),
      build: (final context) => []));
  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final logoImage = pw.MemoryImage(
    (await rootBundle.load('assets/images/flutter_school.png'))
        .buffer
        .asUint8List(),
  );

  return pw.PageTheme(
    margin: const pw.EdgeInsets.symmetric(
      horizontal: 1 * PdfPageFormat.cm,
      vertical: 0.5 * PdfPageFormat.cm,
    ),
    textDirection: pw.TextDirection.ltr,
    orientation: pw.PageOrientation.portrait,
    buildBackground: (final context) => pw.FullPage(
      ignoreMargins: true,
      child: pw.Watermark(
        angle: 20,
        child: pw.Opacity(
          opacity: 0.5,
          child: pw.Image(
            alignment: pw.Alignment.center,
            logoImage,
            fit: pw.BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}

Future<void> saveAsFile(
  final BuildContext context,
  final LayoutCallback build,
  final PdfPageFormat pageFormat,
) async {
  final bytes = build(pageFormat) as List<int>;

  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File('$appDocPath/document.pdf');
  print('save as file ${file.path}');
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);
}

void showPrintedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document printed successfully')));
}

void showSharedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document shared successfully')));
}
