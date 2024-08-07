import 'package:flutter/material.dart';
import 'package:nricse/presentation/pages/faculty_pages/syllabus_copy.dart';
import 'package:nricse/presentation/pages/pdf_list.dart';
import 'package:nricse/presentation/pages/upload_pdf_page.dart'; // Import your upload PDF page

class TimeTables extends StatelessWidget {
  const TimeTables({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const UploadPdfPage()), // Navigate to UploadPDFPage
            );
          },
          child: Text(
            "Time tables",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }
}
