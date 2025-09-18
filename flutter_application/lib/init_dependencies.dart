import 'package:flutter_application/common/secrets/supabase_secrets.dart';
import 'package:flutter_application/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_application/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_application/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_application/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_application/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.supabaseUrl,
    anonKey: SupabaseSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
  _initAuth();
}

void _initAuth() {
  // datasource
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );

  // repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  // usecases
  serviceLocator.registerFactory(
    () => UserSignup(authRepository: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UserLogin(authRepository: serviceLocator()),
  );

  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));

  //bloc
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignup: serviceLocator(),
      userLogin: serviceLocator(),
      currentUser: serviceLocator(),
    ),
  );
}
