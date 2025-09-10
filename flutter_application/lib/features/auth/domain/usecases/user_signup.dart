import 'package:flutter_application/common/error/failure.dart';
import 'package:flutter_application/common/usecase/usecase.dart';
import 'package:flutter_application/features/auth/domain/entities/user.dart';
import 'package:flutter_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements Usecase<User, UserSignupParams> {
  final AuthRepository authRepository;
  const UserSignup({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(UserSignupParams params) async {
    return await authRepository.signupWithCredentials(
      email: params.email,
      username: params.username,
      password: params.password,
    );
  }
}

class UserSignupParams {
  final String email;
  final String username;
  final String password;
  UserSignupParams({
    required this.email,
    required this.username,
    required this.password,
  });
}
