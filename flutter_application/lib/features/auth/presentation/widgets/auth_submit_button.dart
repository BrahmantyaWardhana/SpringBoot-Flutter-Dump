import 'package:flutter/material.dart';
import 'package:flutter_application/common/theme/app_colors.dart';

class AuthSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool loading;
  final String label;

  const AuthSubmitButton({
    super.key,
    required this.onPressed,
    this.loading = false,
    this.label = 'Next',
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.orange,
        elevation: 10,
        shape: const StadiumBorder(),
        textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
        minimumSize: const Size.fromHeight(48),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (loading)
            const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          else
            Text(label, style: const TextStyle(color: Colors.white)),
          const SizedBox(width: 8),
          const Icon(
            Icons.arrow_right_alt_rounded,
            size: 24,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
