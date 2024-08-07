// lib/presentation/bloc/login_state.dart



import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserCredential credential;

  LoginSuccess(this.credential);

  @override
  List<Object?> get props => [credential];
}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);

  @override
  List<Object?> get props => [error];
}
