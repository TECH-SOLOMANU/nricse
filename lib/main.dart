import 'dart:ui';

import 'package:nricse/data/data_source/firebase_api_service_for_login.dart';
import 'package:nricse/firebase_options.dart';
import 'package:nricse/presentation/bloc/admin_draw_main_screen_bloc/admin_draw_main_screen_bloc.dart';
import 'package:nricse/presentation/bloc/faculty_draw_main_screen_bloc/faculty_draw_main_screen_bloc.dart';
import 'package:nricse/presentation/bloc/student_draw_main_screen_bloc/student_draw_main_screen_bloc.dart';
import 'package:nricse/presentation/pages/admin_drawer_main_screen.dart';
import 'package:nricse/presentation/pages/faculty_drawer_main_screen.dart';
import 'package:nricse/presentation/pages/login_screens_of_teacher_student_parent.dart';
import 'package:nricse/presentation/pages/parent_draw_main_screen.dart';
import 'package:nricse/presentation/pages/student_draw_main_screen.dart';
import 'package:nricse/presentation/pages/student_list.dart';
import 'package:nricse/presentation/pages/waiting_screen.dart';
import 'package:nricse/presentation/widgets/Navigating_one_place_to_another_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: PointerDeviceKind.values.toSet(),
      ),
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: Color.fromARGB(255, 16, 232, 145),
        scaffoldBackgroundColor: Color.fromARGB(255, 240, 239, 241),
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
              future: FirebaseApiServiceForLogin().isLoggedIn(),
              builder: (context, AsyncSnapshot<int?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const WaitingScreen();
                } else {
                  var result = snapshot.data;
                  if (result == 0) {
                    return BlocProvider(
                      create: (context) => AdminDrawMainScreenBloc(),
                      child: const AdminDrawerMainScreen(),
                    );
                  } else if (result == 1) {
                    return BlocProvider(
                      create: (context) => FacultyDrawMainScreenBloc(),
                      child: const FacultyDrawerMainScreen(),
                    );
                  } else if (result == 2) {
                    return BlocProvider(
                      create: (context) => StudentDrawMainScreenBloc(),
                      child: const StudentDrawMainScreen(),
                    );
                  } else if (result == 3) {
                    return const ParentDrawMainScreen();
                  } else {
                    return const LoginScreensOfTeacherStudentParent();
                  }
                }
              },
            );
          } else {
            return const WaitingScreen();
          }
        },
      ),
    );
  }
}