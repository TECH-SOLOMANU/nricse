import 'dart:io';

import 'package:nricse/data/model/pdf_model.dart';

abstract class PdfDataSource {
  Future<List<PdfModel>> getPdfs();
  Future<void> uploadPdf(File pdfFile);
}
