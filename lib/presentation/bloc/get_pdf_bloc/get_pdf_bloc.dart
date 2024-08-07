import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse/presentation/bloc/get_pdf_bloc/get_pdf_event.dart';
import 'package:nricse/presentation/bloc/get_pdf_bloc/get_pdf_state.dart';
import 'package:nricse/bussiness/usecase/get_pdf_usecase.dart';

class GetPdfBloc extends Bloc<GetPdfEvent, GetPdfState> {
  final GetPdfsUseCase getPdfsUseCase;

  GetPdfBloc({required this.getPdfsUseCase}) : super(GetPdfInitial()) {
    on<LoadPdfsEvent>(_onLoadPdfs);
  }

  void _onLoadPdfs(LoadPdfsEvent event, Emitter<GetPdfState> emit) async {
    emit(GetPdfLoading());
    try {
      List<Map<String, String?>> pdfList = await getPdfsUseCase.execute();
      emit(GetPdfLoaded(pdfList: pdfList));
    } catch (e) {
      emit(GetPdfError(message: e.toString()));
    }
  }
}
