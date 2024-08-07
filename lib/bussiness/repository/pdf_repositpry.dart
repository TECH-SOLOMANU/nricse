import 'dart:io';

import 'package:nricse/bussiness/entites/pdf_entity.dart';

abstract class PdfRepository {
  Future<List<PdfEntity>> getPdfs();
  Future<void> uploadPdf(File pdfFile);
}
