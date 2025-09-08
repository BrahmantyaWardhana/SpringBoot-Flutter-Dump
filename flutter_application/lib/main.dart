import 'package:flutter/material.dart';
import 'package:flutter_application/common/secrets/supabase_secrets.dart';
import 'package:flutter_application/common/theme/theme.dart';
import 'package:flutter_application/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_application/features/auth/data/repository/auth_repository_impl.dart';
import 'package:flutter_application/features/auth/domain/usecase/user_signup.dart';
import 'package:flutter_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.supabaseUrl,
    anonKey: SupabaseSecrets.supabaseAnonKey,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            userSignup: UserSignup(
              authRepository: AuthRepositoryImpl(
                AuthRemoteDataSourceImpl(supabase.client),
              ),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: AppTheme.appDefaultTheme,
      routerConfig: router,
    );
  }
}
