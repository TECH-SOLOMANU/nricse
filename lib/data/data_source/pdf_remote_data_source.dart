import 'package:firebase_database/firebase_database.dart';

class GetPdfRemoteDataSource {
  final FirebaseDatabase firebaseDatabase;

  GetPdfRemoteDataSource({required this.firebaseDatabase});

  Future<List<Map<String, String?>>> fetchPdfs() async {
    DatabaseReference ref = firebaseDatabase.ref().child('pdfs');
    DatabaseEvent databaseEvent = await ref.once();
    Map<dynamic, dynamic> pdfMap = databaseEvent.snapshot.value as Map<dynamic, dynamic>;

    List<Map<String, String?>> pdfList = [];
    pdfMap.forEach((key, value) {
      pdfList.add({
        'name': value['name'] as String?,
        'base64pdf': value['base64pdf'] as String?
      });
    });
    return pdfList;
  }
}
