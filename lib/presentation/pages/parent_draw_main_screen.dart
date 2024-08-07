import 'package:nricse/bussiness/usecase/retrieve_student_daily_attendance_repository.dart';
import 'package:nricse/data/data_source/firebase_api_service_for_student_result.dart';
import 'package:nricse/data/repository/student_result_repository.dart';
import 'package:nricse/data/repository/student_today_attendance_data_repository.dart';
import 'package:nricse/presentation/bloc/student_result_bloc/student_result_bloc.dart';
import 'package:nricse/presentation/bloc/today_attendance_bloc/today_attendance_bloc.dart';
import 'package:nricse/presentation/pages/pdf_list.dart';
import 'package:nricse/presentation/pages/student_pages/student_result.dart';
import 'package:nricse/presentation/pages/student_pages/today_attendance.dart';
import 'package:nricse/presentation/widgets/navigating_one_place_to_another_place.dart';
import 'package:flutter/material.dart';
import 'package:nricse/common/data.dart';
import 'package:nricse/presentation/pages/login_screens_of_teacher_student_parent.dart';
import 'package:nricse/presentation/widgets/functions_for_sheets_snackbar_banners.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParentDrawMainScreen extends StatelessWidget {
  const ParentDrawMainScreen({super.key});

  Future<void> fetchStudentDetails(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isParent = prefs.getBool('isParent') ?? false;
    String? parentPhoneNumber = prefs.getString('parentPhoneNumber');

    if (isParent && parentPhoneNumber != null) {
      final studentDetails = await fetchStudentDetailsByEmail(parentPhoneNumber);
      if (studentDetails != null) {
        showSnackbarScreen(context, "Student details retrieved successfully");
        // Use the student details as needed, possibly pass to the next screen or use for further logic
      } else {
        showSnackbarScreen(context, "No student details found for this parent");
      }
    } else {
      showSnackbarScreen(context, "Student details retrieved successfully");
    }
  }

  Future<Map<String, dynamic>?> fetchStudentDetailsByEmail(String parentPhoneNumber) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulating network call
    if (parentPhoneNumber == "example_phone_number") {
      return {
        "studentEmail": "student@example.com",
        "studentName": "Student Name",
      };
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parent"),
        actions: [
          TextButton(
              onPressed: () async {
                await firebaseAuth.signOut();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isParent', false);
                await prefs.remove('parentPhoneNumber');
                showSnackbarScreen(context, "Sign Out Successfully");
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) => const LoginScreensOfTeacherStudentParent()));
              },
              child: const Text("Log out"))
        ],
      ),
      body: ListView(
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              await fetchStudentDetails(context);
              NavigatingOnePlaceToAnotherPlace().navigatePage(
                context,
                BlocProvider(
                  create: (context) => TodayAttendanceBloc(
                    retrieveStudentDailyAttendanceRepository:
                        RetrieveStudentDailyAttendanceRepository(
                      todayAttendanceBusinessRepository:
                          StudentTodayAttendanceDataRepository(),
                    ),
                  ),
                  child: const TodayAttendance(),
                ),
              );
            },
            icon: const Icon(Icons.co_present_sharp),
            label: const Text("Today Attendance"),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () async {
              await fetchStudentDetails(context);
              NavigatingOnePlaceToAnotherPlace().navigatePage(
                context,
                BlocProvider(
                  create: (context) => StudentResultBloc(
                    studentBussinessRepository: StudentResultRepository(
                      firebaseApiServiceForStudentResult:
                          FirebaseApiServiceForStudentResult(),
                    ),
                  ),
                  child: const StudentResult(),
                ),
              );
            },
            icon: const Icon(Icons.real_estate_agent_outlined),
            label: const Text("Result"),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GetPdfList(),
                ),
              );
            },
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text("View PDFs"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
