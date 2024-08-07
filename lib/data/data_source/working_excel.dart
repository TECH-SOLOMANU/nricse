import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nricse/presentation/widgets/functions_for_sheets_snackbar_banners.dart';


List<List<String>> ListOfOutput = [];


class WorkingExcel {
  String filePath = '';
  FilePickerResult resultPicker = const FilePickerResult([]);
   

  Future<String> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );
    if (result != null) {
      resultPicker = result;
      filePath = result.files.single.path!;
      await readExcelDataConvertIntoList(context, filePath);
      return result.files.single.name;
    }
    return "";
  }

  Future<List<List<String>>> readExcel(String filePath) async {
    var bytes = File(filePath).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    List<List<String>> excelData = [];
    var count = 0;
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        List<String> rowData = [];
        for (var cell in row) {
          if (cell?.value != null) {
            rowData.add(cell!.value.toString().trim());
          }
        }
        count++;
        if (rowData.isNotEmpty && count > 1) {
          excelData.add(rowData);
        }
      }
    }

    // _excelData.removeAt(0);
    return excelData;
  }

  Future<void> readExcelDataConvertIntoList(
      BuildContext context, String filePath) async {
    await readExcel(filePath).then((value) {
      ListOfOutput = value;
      print(value);
      showSnackbarScreen(context, "${ListOfOutput.length} rows");
    });
  }
}
