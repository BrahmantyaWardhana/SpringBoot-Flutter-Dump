import 'package:flutter_application/common/error/exceptions.dart';
import 'package:flutter_application/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signupWithCredentials({
    required String email,
    required String username,
    required String password,
  });
  Future<UserModel> loginWithCredentials({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> signupWithCredentials({
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
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithCredentials({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithCredentials
    throw UnimplementedError();
  }
}
