import 'package:flutter_application/common/error/failure.dart';
import 'package:flutter_application/common/usecase/usecase.dart';
import 'package:flutter_application/features/auth/domain/entities/user.dart';
import 'package:flutter_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements Usecase<User, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLogin({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithCredentials(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
