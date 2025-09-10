import 'package:flutter_application/common/secrets/supabase_secrets.dart';
import 'package:flutter_application/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_application/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_application/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_application/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.supabaseUrl,
    anonKey: SupabaseSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UserSignup(authRepository: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UserLogin(authRepository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(userSignup: serviceLocator(), userLogin: serviceLocator()),
  );
}
