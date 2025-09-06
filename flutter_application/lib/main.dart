import 'package:flutter/material.dart';
import 'package:flutter_application/common/secrets/supabase_secrets.dart';
import 'package:flutter_application/common/theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.supabaseUrl,
    anonKey: SupabaseSecrets.supabaseAnonKey,
  );
  runApp(const MyApp());
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
