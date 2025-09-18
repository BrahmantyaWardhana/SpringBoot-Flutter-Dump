import 'package:flutter/material.dart';
import 'package:flutter_application/common/theme/theme.dart';
import 'package:flutter_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_application/init_dependencies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>()..add(AuthIsUserLoggedIn()),
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
