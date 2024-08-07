import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';

class UploadPdfPage extends StatefulWidget {
  const UploadPdfPage({super.key});

  @override
  _UploadPdfPageState createState() => _UploadPdfPageState();
}

class _UploadPdfPageState extends State<UploadPdfPage> {
  File? _selectedPdf;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload PDF'),
      ),
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

      // Encode PDF bytes to base64
      String base64Pdf = base64Encode(pdfBytes);

      // Extract the name of the PDF
      String pdfName = _selectedPdf!.uri.pathSegments.last;

      // Store base64 encoded PDF and its name in Firebase Realtime Database
      await FirebaseDatabase.instance.ref('pdfs').push().set({
        'base64pdf': base64Pdf,
        'name': pdfName,  // Store the PDF name
      });

      print('PDF uploaded and base64 data stored in Firebase');
    } catch (e) {
      print('Failed to upload PDF file: $e');
    }
  }
}
