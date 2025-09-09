import 'package:flutter_application/common/error/failure.dart';
import 'package:flutter_application/features/auth/domain/entity/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signupWithCredentials({
    required String email,
    required String username,
    required String password,
  });
  Future<Either<Failure, User>> loginWithCredentials({
    required String email,
    required String password,
  });
}
