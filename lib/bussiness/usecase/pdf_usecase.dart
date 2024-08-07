import 'dart:io';

import 'package:nricse/bussiness/entites/pdf_entity.dart';
import 'package:nricse/bussiness/repository/pdf_repositpry.dart';

class PdfUseCase {
  final PdfRepository _repository;

  PdfUseCase(this._repository);

  Future<List<PdfEntity>> getPdfs() async {
    return await _repository.getPdfs();
  }

  Future<void> uploadPdf(File pdfFile) async {
    await _repository.uploadPdf(pdfFile);
  }
}
