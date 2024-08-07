// lib/presentation/bloc/login_event.dart



abstract class LoginEvent{
  @override
  List<Object?> get props => [];
}

class LoginRequested extends LoginEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}
