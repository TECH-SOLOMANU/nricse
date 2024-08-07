import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckTheLoginUser extends StatefulWidget {
  const CheckTheLoginUser({super.key});

  @override
  _CheckTheLoginUserState createState() => _CheckTheLoginUserState();
}

class _CheckTheLoginUserState extends State<CheckTheLoginUser> {
  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  Future<void> _checkUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User is not logged in
      Navigator.of(context).pushReplacementNamed('/login'); // Replace with your login screen route
    } else {
      // User is logged in, check role or navigate to appropriate screen
      // Example: Check if user is an admin, faculty, or student
      // This example assumes that roles are stored in the user's custom claims
      final userId = user.uid;
      final userRoles = await _getUserRoles(userId); // Implement this function to fetch roles

      if (userRoles.contains('admin')) {
        Navigator.of(context).pushReplacementNamed('/adminDashboard'); // Replace with your admin dashboard route
      } else if (userRoles.contains('faculty')) {
        Navigator.of(context).pushReplacementNamed('/facultyDashboard'); // Replace with your faculty dashboard route
      } else if (userRoles.contains('student')) {
        Navigator.of(context).pushReplacementNamed('/studentDashboard'); // Replace with your student dashboard route
      } else {
        Navigator.of(context).pushReplacementNamed('/unknownRole'); // Fallback route
      }
    }
  }

  Future<List<String>> _getUserRoles(String userId) async {
    // Implement a method to fetch user roles from your database
    // This is just a placeholder
    return ['student']; // Return roles based on your database
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Show a loading spinner while checking user role
      ),
    );
  }
}
