abstract class GetPdfState {}

class GetPdfInitial extends GetPdfState {}

class GetPdfLoading extends GetPdfState {}

class GetPdfLoaded extends GetPdfState {
  final List<Map<String, String?>> pdfList;
  GetPdfLoaded({required this.pdfList});
}

class GetPdfError extends GetPdfState {
  final String message;
  GetPdfError({required this.message});
}
