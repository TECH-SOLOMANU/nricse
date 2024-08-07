// repository/forgot_password_repository_impl.dart
import 'package:nricse/bussiness/repository/forgot_password_repository.dart';
import 'package:nricse/data/data_source/forgot_password_data_source.dart';


class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordDataSource dataSource;

  ForgotPasswordRepositoryImpl(this.dataSource);

  @override
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await dataSource.sendPasswordResetEmail(email);
      return true;
    } catch (e) {
      // Handle error, maybe log it or convert to a user-friendly message
      return false;
    }
  }
}
