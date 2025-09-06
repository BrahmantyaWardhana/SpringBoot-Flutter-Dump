import 'package:flutter_application/common/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signupWithCredentials({
    required String phone,
    required String name,
    required String password,
  });
  Future<Either<Failure, String>> loginWithCredentials({
    required String phone,
    required String password,
  });
}
