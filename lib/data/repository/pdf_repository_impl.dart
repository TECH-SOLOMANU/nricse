import 'dart:io';

import 'package:nricse/bussiness/entites/pdf_entity.dart';
import 'package:nricse/bussiness/repository/pdf_repositpry.dart';
import 'package:nricse/data/data_source/pdf_data_source.dart';
import 'package:nricse/data/model/pdf_model.dart';

class PdfRepositoryImpl implements PdfRepository {
  final PdfDataSource _dataSource;

  PdfRepositoryImpl(this._dataSource);

  @override
  Future<List<PdfEntity>> getPdfs() async {
    List<PdfModel> pdfModels = await _dataSource.getPdfs();
    return pdfModels.map((model) => PdfEntity(id: model.id, name: model.name, url: model.url)).toList();
  }

  @override
  Future<void> uploadPdf(File pdfFile) async {
    await _dataSource.uploadPdf(pdfFile);
  }
}
