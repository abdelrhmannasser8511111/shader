import 'dart:typed_data';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';

class PdfBllPage extends StatelessWidget {
  const PdfBllPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     appBar: AppBar(
       backgroundColor: Color(0xff22a39f),
     ),
      body: Theme(
        data: Theme.of(context).copyWith(
          // set your background color here
          primaryColor:Color(0xff22a39f)  ,
          // set your icon color here
          primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(color: Color(0xffeff3f2) ) ,
        ),
        child: PdfPreview(

          pdfPreviewPageDecoration:BoxDecoration(

          ) ,
          canDebug: false,
          initialPageFormat: PdfPageFormat.a4,
          // pageFormats:{"1":PdfPageFormat.a4} ,
          build: (format) => generatePdf(format, 'title'),
        ),
      ),
    );
  }
}





Future<Uint8List> generatePdf(PdfPageFormat format, String title) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

  final font = await PdfGoogleFonts.nunitoExtraLight();

  pdf.addPage(
    pw.Page(
      pageFormat: format,
      build: (context) {
        return pw.Column(
          children: [
            pw.SizedBox(
              width: double.infinity,
              child: pw.Text(title, style: pw.TextStyle(font: font)),

            ),
            pw.SizedBox(height: 20),
            pw.Flexible(child: pw.FlutterLogo())
          ],
        );
      },
    ),
  );

  return pdf.save();
}