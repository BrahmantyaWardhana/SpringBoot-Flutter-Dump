import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signupWithCredentials({
    required String email,
    required String name,
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
    required String name,
    required String password,
  }) async {
    final response = await supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: {
        'name': name,
      },
    );

    final user = response.user;
    if (user == null) {
      throw AuthException('Signup failed');
    }
    return user.id;
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
