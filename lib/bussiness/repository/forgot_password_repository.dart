// repository/forgot_password_repository.dart
abstract class ForgotPasswordRepository {
  Future<bool> sendPasswordResetEmail(String email);
}
