import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nricse/common/custom_snack_bar.dart';
import 'package:nricse/common/data.dart';
import 'package:nricse/data/model/faculty_data_model.dart';

class FirebaseApiServiceForRetrieveListOfFacultyModel {
  final DatabaseReference _facultyRef = database.child('facultyDetails');

  Future<List<FacultyModel>> getFacultyList(BuildContext context) async {
    try {
      DatabaseEvent databaseEvent = await _facultyRef.once();
      DataSnapshot snapshot = databaseEvent.snapshot;
      if (snapshot.value != null) {
        final List<FacultyModel> facultyList = [];
        final mapOfEvents = snapshot.value as Map;

        // Iterate over the map entries and convert them to FacultyModel objects
        mapOfEvents.forEach((key, value) {
          print(value);
          List<String> subjects = [];
          if (value['subjects'] != null && value['subjects'] is List) {
            subjects = (value['subjects'] as List).whereType<String>().toList();
          }

          facultyList.add(FacultyModel(
              name: value['name'],
              previousExperience: value['previousExperience'],
              mobileNumber: value['mobileNumber'],
              mailId: value['mailId'],
              subjects: subjects));
        });

        print(facultyList);

        return facultyList;
      } else {
        CustomSnackBar().show(context, "No data found.");
        return [];
      }
    } catch (e) {
      print(e.toString());
      CustomSnackBar().show(context, "Error: $e");
      return [];
    }
  }
}
