import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nricse/presentation/pages/admin_drawer_main_screen.dart';
import 'package:nricse/presentation/pages/faculty_drawer_main_screen.dart';
import 'package:nricse/presentation/pages/student_list.dart';
import 'package:nricse/presentation/pages/parent_draw_main_screen.dart';
import 'package:nricse/presentation/widgets/Navigating_one_place_to_another_place.dart';
import 'package:nricse/presentation/widgets/functions_for_sheets_snackbar_banners.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseApiServiceForLogin {
  Future<bool> login_email_password(BuildContext context, String emailAddress,
      String password, String whoAreYou) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFaculty', whoAreYou == 'isFaculty'); // Only setting for faculty

      showSnackbarScreen(context, "Successfully logged in");

      bool isAdmin = whoAreYou == 'isAdmin';
      bool isFaculty = whoAreYou == 'isFaculty';
      bool isStudent = whoAreYou == 'isStudent';
      var selectDestination = isAdmin
          ? const AdminDrawerMainScreen()
          : isFaculty
              ? const FacultyDrawerMainScreen()
              : isStudent
                  ? const StudentDrawMainScreen()
                  : const ParentDrawMainScreen();

      NavigatingOnePlaceToAnotherPlace()
          .navigatePageDeletePervious(context, selectDestination);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackbarScreen(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackbarScreen(context, 'Wrong password provided for that user.');
      } else {
        showSnackbarScreen(context, e.message ?? 'An error occurred.');
      }
    } catch (e) {
      showSnackbarScreen(context, 'An unexpected error occurred.');
    }
    return false;
  }

  Future<int> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isAdmin') ?? false) {
      return 0;
    } else if (prefs.getBool('isFaculty') ?? false) {
      return 1;
    } else if (prefs.getBool('isStudent') ?? false) {
      return 2;
    } else if (prefs.getBool('isParent') ?? false) {
      return 3;
    }
    return 4;
  }
}
