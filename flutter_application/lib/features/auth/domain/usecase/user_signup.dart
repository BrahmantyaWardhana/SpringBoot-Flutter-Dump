import 'package:flutter_application/common/error/failure.dart';
import 'package:flutter_application/common/usecase/usecase.dart';
import 'package:flutter_application/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements Usecase<String, UserSignupParams> {
  final AuthRepository authRepository;
  const UserSignup({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(UserSignupParams params) async {
    return await authRepository.signupWithCredentials(
      email: params.email,
      name: params.name,
      password: params.password,
    );
  }
}

class UserSignupParams {
  final String email;
  final String name;
  final String password;
  UserSignupParams({
    required this.email,
    required this.name,
    required this.password,
  });
}
