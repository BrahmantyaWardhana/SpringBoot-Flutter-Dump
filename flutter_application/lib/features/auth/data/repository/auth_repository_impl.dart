import 'package:flutter_application/common/error/exceptions.dart';
import 'package:flutter_application/common/error/failure.dart';
import 'package:flutter_application/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_application/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> loginWithCredentials({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithCredentials
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signupWithCredentials({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.signupWithCredentials(
        email: email,
        username: username,
        password: password,
      );

      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
