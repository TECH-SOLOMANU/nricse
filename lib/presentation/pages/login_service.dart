import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LoginService {
  final DatabaseReference _userRef = FirebaseDatabase.instance.ref('users');

  Future<bool> validateUser(String email, String password) async {
    final snapshot = await _userRef.orderByChild('email').equalTo(email).once();

    if (snapshot.snapshot.exists) {
      final user = snapshot.snapshot.children.first;

      // Check if the password matches
      return user.child('password').value.toString() == password;
    }
    return false;
  }

  Future<void> loginUser(BuildContext context, String email, String password) async {
    try {
      bool isValid = await validateUser(email, password);
      if (isValid) {
        // Navigate to the home screen or handle successful login
        Navigator.of(context).pushReplacementNamed('/home');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login successful.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid email or password.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }
}
