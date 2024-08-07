// lib/domain/usecases/login_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nricse/bussiness/entites/user_entity.dart';


class LoginUseCase {
  final FirebaseAuth _firebaseAuth;

  LoginUseCase(this._firebaseAuth);

  Future<Either<String, UserCredential>> execute(UserEntity user) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      return Right(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return Left('Wrong password provided for that user.');
      }
      return Left(e.message ?? 'An error occurred.');
    } catch (e) {
      return Left('An unexpected error occurred.');
    }
  }
}
