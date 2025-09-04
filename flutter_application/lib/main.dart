import 'package:flutter/material.dart';
import 'package:flutter_application/common/theme/theme.dart';

import 'features/auth/presentation/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: AppTheme.appDefaultTheme,
      home: const SignupPage(),
    );
  }
}
