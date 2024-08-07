// bloc/forgot_password_bloc/forgot_password_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nricse/bussiness/entites/forgot_password_entity.dart';
import 'package:nricse/bussiness/usecase/forgot_password_usecase.dart';
import 'package:nricse/presentation/bloc/forgot_password_bloc/forgot_password_event.dart';
import 'package:nricse/presentation/bloc/forgot_password_bloc/forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordBloc(this.forgotPasswordUseCase) : super(ForgotPasswordInitial()) {
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
  }

  Future<void> _onForgotPasswordRequested(
    ForgotPasswordRequested event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(ForgotPasswordLoading());
    try {
      final result = await forgotPasswordUseCase.execute(
        ForgotPasswordEntity(event.email),
      );
      if (result) {
        emit(ForgotPasswordSuccess());
      } else {
        emit(ForgotPasswordError("Failed to send reset email"));
      }
    } catch (e) {
      emit(ForgotPasswordError("An error occurred"));
    }
  }
}
