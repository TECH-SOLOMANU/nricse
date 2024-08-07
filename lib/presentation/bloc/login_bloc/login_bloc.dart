// lib/presentation/bloc/login_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse/bussiness/entites/user_entity.dart';
import 'package:nricse/bussiness/usecase/login_usecase.dart';
import 'package:nricse/presentation/bloc/login_bloc/login_event.dart';
import 'package:nricse/presentation/bloc/login_bloc/login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginRequested) {
      yield LoginLoading();
      final user = UserEntity(email: event.email, password: event.password);
      final result = await _loginUseCase.execute(user);

      yield result.fold(
        (error) => LoginError(error),
        (credential) => LoginSuccess(credential),
      );
    }
  }
}
