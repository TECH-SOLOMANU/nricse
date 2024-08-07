

import 'package:nricse/bussiness/entites/forgot_password_entity.dart';
import 'package:nricse/bussiness/repository/forgot_password_repository.dart';

class ForgotPasswordUseCase {
  final ForgotPasswordRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<bool> execute(ForgotPasswordEntity entity) async {
    return await repository.sendPasswordResetEmail(entity.email);
  }
}
