import 'package:meta/meta.dart';

@immutable
abstract class PdfState {}

class PdfInitial extends PdfState {}

class PdfUploaded extends PdfState {
  final String downloadUrl;

  PdfUploaded({required this.downloadUrl});
}

class PdfError extends PdfState {
  final String message;

  PdfError({required this.message});
}