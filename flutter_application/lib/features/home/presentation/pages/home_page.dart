import 'package:flutter/material.dart';
import 'package:flutter_application/common/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
        child: Text(
          style: TextStyle(color: AppColors.lightPurple),
          'Welcome! You are on the home page.',
        ),
      ),
    );
  }
}
