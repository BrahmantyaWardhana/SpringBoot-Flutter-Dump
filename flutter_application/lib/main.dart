import 'package:flutter/material.dart';
import 'package:flutter_application/common/theme/theme.dart';

import 'routes.dart';

void main() async {
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
