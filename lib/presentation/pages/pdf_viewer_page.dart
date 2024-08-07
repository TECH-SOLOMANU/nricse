import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfUrl; // Provide the URL of the PDF file

  const PdfViewerPage(this.pdfUrl, {super.key});

  Future<void> _launchPdf() async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      throw 'Could not launch $pdfUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _launchPdf,
          child: const Text('Open PDF'),
        ),
      ),
    );
  }
}
