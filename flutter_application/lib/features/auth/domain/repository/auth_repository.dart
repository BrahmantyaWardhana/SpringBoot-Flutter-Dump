import 'package:flutter_application/common/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signupWithCredentials({
    required String email,
    required String name,
    required String password,
  });
  Future<Either<Failure, String>> loginWithCredentials({
    required String email,
    required String password,
  });
}
