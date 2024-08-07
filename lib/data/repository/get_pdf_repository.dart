import 'package:nricse/data/data_source/pdf_remote_data_source.dart';

class GetPdfRepository {
  final GetPdfRemoteDataSource remoteDataSource;

  GetPdfRepository({required this.remoteDataSource});

  Future<List<Map<String, String?>>> getPdfs() async {
    try {
      return await remoteDataSource.fetchPdfs();
    } catch (e) {
      throw Exception('Failed to load PDFs: $e');
    }
  }
}
