import 'dart:io';
import 'dart:convert'; // For base64 encoding

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nricse/presentation/bloc/pdf_bloc/pdf_bloc.dart';
import 'package:nricse/presentation/pages/upload_pdf_page.dart'; // Adjust as per your project structure

class AcademicCalenders extends StatefulWidget {
  const AcademicCalenders({super.key});

  @override
  _UploadPdfPageState createState() => _UploadPdfPageState();
}

class _UploadPdfPageState extends State<AcademicCalenders> {
  final PdfBloc _pdfBloc = PdfBloc();
  File? _selectedPdf;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _pdfBloc,
      child: Scaffold(
     
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _pickAndUploadPdf,
                child: const Text('Pick and Upload PDF'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickAndUploadPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedPdf = File(result.files.single.path!);
      });

      _uploadPdf();
    }
  }

  void _uploadPdf() async {
    if (_selectedPdf == null) return;

    try {
      // Read the PDF file as bytes
      List<int> pdfBytes = await _selectedPdf!.readAsBytes();

      // Encode PDF bytes to base64 (Firebase Realtime Database can store base64 strings)
      String base64Pdf = base64Encode(pdfBytes);

      // Store base64 encoded PDF in Firebase Realtime Databas
      await FirebaseDatabase.instance.ref('pdfs').push().set({
        'base64pdf': base64Pdf,
        // You can add additional metadata if needed
      });

      print('PDF uploaded and base64 data stored in Firebase');
    } catch (e) {
      print('Failed to upload PDF file: $e');
    }
  }

  @override
  void dispose() {
    _pdfBloc.close();
    super.dispose();
  }
}