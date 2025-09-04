import 'package:flutter/material.dart';
import 'package:flutter_application/common/theme/app_colors.dart';

class AppTheme {
  static final appDefaultTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.purple,
    textTheme: ThemeData().textTheme.apply(
      bodyColor: AppColors.purpleText,
      displayColor: AppColors.purpleText,
    ),
  );
}
