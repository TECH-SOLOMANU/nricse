import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nricse/presentation/widgets/functions_for_sheets_snackbar_banners.dart';

class FirebaseApiServiceForSignup {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<bool> register_email_password(
    BuildContext context,
    String emailAddress,
    String password,
    String whoAreYou,
  ) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      showSnackbarScreen(context, "Successfully Registered The User");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackbarScreen(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackbarScreen(context, "The account already exists for that email.");
      }
    } catch (e) {
      showSnackbarScreen(context, e.toString());
    }
    return false;
  }

  Future<void> sendPasswordResetEmail(BuildContext context, String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      showSnackbarScreen(context, 'Password reset email sent.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        showSnackbarScreen(context, 'Invalid email address.');
      } else if (e.code == 'user-not-found') {
        showSnackbarScreen(context, 'No user found with that email.');
      }
    } catch (e) {
      showSnackbarScreen(context, e.toString());
    }
  }
}
