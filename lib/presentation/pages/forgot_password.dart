// pages/forgot_password.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse/bussiness/usecase/forgot_password_usecase.dart';
import 'package:nricse/data/data_source/forgot_password_data_source.dart';
import 'package:nricse/data/repository/forgot_password_data_repo.dart';
import 'package:nricse/presentation/bloc/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:nricse/presentation/bloc/forgot_password_bloc/forgot_password_event.dart';
import 'package:nricse/presentation/bloc/forgot_password_bloc/forgot_password_state.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(
        ForgotPasswordUseCase(
          ForgotPasswordRepositoryImpl(
            ForgotPasswordDataSource(FirebaseAuth.instance),
          ),
        ),
      ),
      child: const ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final emailController = TextEditingController();
  bool isSubmitting = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Enter your email',
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
              listener: (context, state) {
                if (state is ForgotPasswordSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password reset email sent')),
                  );
                  Navigator.of(context).pop();
                } else if (state is ForgotPasswordError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is ForgotPasswordLoading) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    final email = emailController.text;
                    if (email.isNotEmpty) {
                      BlocProvider.of<ForgotPasswordBloc>(context).add(
                        ForgotPasswordRequested(email),
                      );
                    }
                  },
                  child: const Text('Send Reset Email'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
