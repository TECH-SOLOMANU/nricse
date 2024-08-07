import 'package:nricse/data/repository/get_pdf_repository.dart';

class GetPdfsUseCase {
  final GetPdfRepository repository;

  GetPdfsUseCase({required this.repository});

  Future<List<Map<String, String?>>> execute() async {
    return await repository.getPdfs();
  }
}
