import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:nricse/common/custom_snack_bar.dart';
import 'package:nricse/common/data.dart';

class RetrieveFacultySubjects {
  Future<List<String>> getSubjectsForFaculty(
      String email, BuildContext context) async {
    List<String> subjects = [];

    try {
      DatabaseReference ref = database.child('facultyDetails');

      // Query to find the faculty with the provided email
      DatabaseEvent databaseEvent =
          await ref.orderByChild('mailId').equalTo(email).once();

      if (databaseEvent.snapshot.value != null) {
        Map<dynamic, dynamic> facultyData = databaseEvent.snapshot.value as Map;

        // Iterate over the faculty data to get the subjects
        facultyData.forEach((key, value) {
          if (value['subjects'] != null) {
            List<dynamic> subjectsData = value['subjects'];
            for (var subject in subjectsData) {
              subjects.add(subject);
            }
          }
        });
      }
    } catch (error) {
      // ignore: use_build_context_synchronously
      CustomSnackBar().show(context, error.toString());
    }

    return subjects;
  }
}
