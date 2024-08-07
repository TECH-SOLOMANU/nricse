// data_source/forgot_password_data_source.dart
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordDataSource {
  final FirebaseAuth firebaseAuth;

  ForgotPasswordDataSource(this.firebaseAuth);

  Future<void> sendPasswordResetEmail(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
