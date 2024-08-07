import 'dart:io';

import 'package:meta/meta.dart';

@immutable
abstract class PdfEvent {}

class UploadPdfEvent extends PdfEvent {
  final File pdfFile;

  UploadPdfEvent(this.pdfFile);
}