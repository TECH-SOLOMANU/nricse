import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:nricse/presentation/bloc/pdf_bloc/pdf_event.dart';
import 'package:nricse/presentation/bloc/pdf_bloc/pdf_state.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';


class PdfBloc extends Bloc<PdfEvent, PdfState> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  PdfBloc() : super(PdfInitial());

  @override
  Stream<PdfState> mapEventToState(
    PdfEvent event,
  ) async* {
    if (event is UploadPdfEvent) {
      yield* _mapUploadPdfEventToState(event.pdfFile);
    }
  }

  Stream<PdfState> _mapUploadPdfEventToState(File pdfFile) async* {
    try {
      // Upload PDF file to Firebase Storage
      Reference storageRef = FirebaseStorage.instance.ref().child('pdfs/${pdfFile.path.split('/').last}');
      await storageRef.putFile(pdfFile);
      String downloadUrl = await storageRef.getDownloadURL();

      // Store download URL in Firebase Realtime Database
      await _databaseReference.child('pdfs').push().set({
        'url': downloadUrl,
        // Add additional metadata as needed
      });

      yield PdfUploaded(downloadUrl: downloadUrl);
    } catch (e) {
      yield PdfError(message: 'Failed to upload PDF file: $e');
    }
  }
}
