// lib/domain/repositories/auth_repository.dart

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nricse/bussiness/entites/user_entity.dart';


abstract class AuthRepository {
  Future<Either<String, UserCredential>> login(UserEntity user);
}
