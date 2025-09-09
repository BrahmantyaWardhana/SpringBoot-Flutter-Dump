import 'package:flutter_application/common/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signupWithCredentials({
    required String email,
    required String username,
    required String password,
  });
  Future<String> loginWithCredentials({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<String> signupWithCredentials({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'username': username},
      );

      if (response.user == null) {
        throw ServerException('User is null');
      }
      return response.user!.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> loginWithCredentials({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithCredentials
    throw UnimplementedError();
  }
}
