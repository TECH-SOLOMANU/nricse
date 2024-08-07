import 'package:flutter/material.dart';
import 'package:nricse/common/check_the_login_user.dart';
import 'package:nricse/data/data_source/data.dart';
import 'package:nricse/data/data_source/firebase_api_service_for_login.dart';
import 'package:nricse/data/data_source/firebase_api_service_for_signup.dart';
import 'package:nricse/presentation/pages/forgot_password.dart';
import 'package:nricse/presentation/pages/login_admin_screen.dart';
import 'package:nricse/presentation/widgets/navigating_one_place_to_another_place.dart';
import 'package:nricse/presentation/widgets/functions_for_sheets_snackbar_banners.dart';

class LoginScreensOfTeacherStudentParent extends StatefulWidget {
  const LoginScreensOfTeacherStudentParent({super.key});

  @override
  _LoginScreensOfTeacherStudentParentState createState() =>
      _LoginScreensOfTeacherStudentParentState();
}

class _LoginScreensOfTeacherStudentParentState
    extends State<LoginScreensOfTeacherStudentParent> {
  var currentRole;
  final double sizeOfIcons = 100.0; // Increased size
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isSignUp = false;
  var isPasswordHidden = true;

  @override
  void initState() {
    currentRole = 0; // Default role, adjust as needed
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AdminLoginScreen(),
                ),
              );
            },
            child: const Text("Admin", style: TextStyle(color: Color.fromARGB(255, 26, 67, 205))),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 239, 229, 238),
        scrolledUnderElevation: 0,
        surfaceTintColor: const Color.fromARGB(255, 30, 221, 221),
      ),
      backgroundColor: const Color.fromARGB(255, 11, 219, 194),
      body: Container(
        color: const Color.fromARGB(255, 229, 233, 233),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome...!",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: const Color.fromARGB(255, 183, 16, 35),
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...listOFUsers.map((e) {
                    int index = listOFUsers.indexOf(e);
                    return InkWell(
                      onTap: () {
                        setState(() {
                          currentRole = index;
                        });
                      },
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            side: BorderSide(
                                width: 3,
                                style: BorderStyle.solid,
                                color: currentRole == index
                                    ? const Color.fromARGB(255, 16, 7, 93)
                                    : Colors.white),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              e.toString() == 'Teacher'
                                  ? Image.asset(
                                      "assets/images/teacher.png",
                                      width: sizeOfIcons,
                                      height: sizeOfIcons,
                                    )
                                  : e.toString() == 'Student'
                                      ? Image.asset(
                                          "assets/images/graduated.png",
                                          width: sizeOfIcons,
                                          height: sizeOfIcons,
                                        )
                                      : Image.asset(
                                          "assets/images/parents.png",
                                          width: sizeOfIcons,
                                          height: sizeOfIcons,
                                        ),
                              Text(
                                e.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(color: Color.fromARGB(255, 213, 216, 227)),
                    ),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            label: Text("E-mail"),
                            suffixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: isPasswordHidden,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            label: const Text("Password"),
                            labelStyle: const TextStyle(
                                overflow: TextOverflow.ellipsis),
                            suffixIcon: isPasswordHidden
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPasswordHidden = false;
                                      });
                                    },
                                    child: const Icon(Icons.remove_red_eye))
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPasswordHidden = true;
                                      });
                                    },
                                    child: const Icon(
                                        Icons.remove_red_eye_outlined)),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              print(currentRole);
                              print(CheckTheUser().checkUser(currentRole));
                              bool result = isSignUp
                                  ? await FirebaseApiServiceForSignup()
                                      .register_email_password(
                                          context,
                                          emailController.text,
                                          passwordController.text,
                                          CheckTheUser()
                                              .checkUser(currentRole))
                                  : await FirebaseApiServiceForLogin()
                                      .login_email_password(
                                          context,
                                          emailController.text,
                                          passwordController.text,
                                          CheckTheUser()
                                              .checkUser(currentRole));
                              if (result) {
                                isSignUp
                                    ? showSnackbarScreen(context,
                                        "Account creation successfully completed")
                                    : showSnackbarScreen(context,
                                        "Login successfully completed");

                                if (isSignUp) {
                                  setState(() {
                                    isSignUp = false;
                                  });
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(163, 220, 5, 206), // Button color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              isSignUp ? "Sign Up" : "Login",
                              style: const TextStyle(fontSize: 18,color:Color.fromARGB(255, 238, 236, 241)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (!isSignUp )
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  isSignUp = true;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.green, // Background color for Sign Up button
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        AnimatedSize(
                          duration: const Duration(seconds: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isSignUp = !isSignUp;
                                    });
                                  },
                                  child: const Text(
                                    "Already have an account",
                                    style: TextStyle(color: Color.fromARGB(255, 36, 40, 159)),
                                  ),
                                ),
                              TextButton(
                                onPressed: () {
                                  NavigatingOnePlaceToAnotherPlace()
                                      .navigatePage(
                                          context, const ForgotPasswordPage());
                                },
                                child: const Text(
                                  "Forgot Password",
                                  style: TextStyle(color: Color.fromARGB(255, 18, 87, 225)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
