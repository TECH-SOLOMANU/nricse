import 'dart:convert';
import 'dart:io';
import 'package:nricse/bussiness/usecase/get_pdf_usecase.dart';
import 'package:nricse/data/data_source/pdf_remote_data_source.dart';
import 'package:nricse/data/repository/get_pdf_repository.dart';
import 'package:nricse/presentation/bloc/get_pdf_bloc/get_pdf_event.dart';
import 'package:nricse/presentation/bloc/get_pdf_bloc/get_pdf_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:nricse/presentation/bloc/get_pdf_bloc/get_pdf_bloc.dart';
import 'package:firebase_database/firebase_database.dart';

class TimeTables extends StatelessWidget {
  const TimeTables({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetPdfBloc(
        getPdfsUseCase: GetPdfsUseCase(
          repository: GetPdfRepository(
            remoteDataSource: GetPdfRemoteDataSource(
              firebaseDatabase: FirebaseDatabase.instance,
            ),
          ),
        ),
      )..add(LoadPdfsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Time Table'),
        ),
        body: BlocBuilder<GetPdfBloc, GetPdfState>(
          builder: (context, state) {
            if (state is GetPdfLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetPdfLoaded) {
              return ListView.builder(
                itemCount: state.pdfList.length,
                itemBuilder: (context, index) {
                  String? pdfName = state.pdfList[index]['name'];
                  String? base64Pdf = state.pdfList[index]['base64pdf'];

                  // Logging to debug the data
                  print('PDF ${index + 1}: name=$pdfName, base64pdf=$base64Pdf');

                  return ListTile(
                    title: Text(pdfName ?? 'Unknown PDF'),
                    onTap: base64Pdf != null ? () => _openPdf(base64Pdf) : null,
                  );
                },
              );
            } else if (state is GetPdfError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('No PDFs found'));
            }
          },
        ),
      ),
    );
  }

  void _openPdf(String base64Pdf) async {
    try {
      List<int> pdfBytes = base64Decode(base64Pdf);
      Directory tempDir = await getTemporaryDirectory();
      String uniqueFileName = 'temp_pdf_${DateTime.now().millisecondsSinceEpoch}.pdf';
      File tempFile = File('${tempDir.path}/$uniqueFileName');
      await tempFile.writeAsBytes(pdfBytes);
      OpenFile.open(tempFile.path);
    } catch (e) {
      print('Failed to open PDF: $e');
    }
  }
}



