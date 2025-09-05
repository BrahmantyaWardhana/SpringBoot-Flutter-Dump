import 'package:flutter/material.dart';
import 'package:flutter_application/common/theme/app_colors.dart';

class AuthSignupCta extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool loading;
  final String label;

  const AuthSignupCta({
    super.key,
    required this.onPressed,
    this.loading = false,
    this.label = 'Next',
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {}, // no functionality yet
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.orange,
        elevation: 10,
        shape: const StadiumBorder(),
        textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Next', style: TextStyle(color: Colors.white)),
          SizedBox(width: 8),
          Icon(Icons.arrow_right_alt_rounded, size: 24, color: Colors.white),
        ],
      ),
    );
  }
}
