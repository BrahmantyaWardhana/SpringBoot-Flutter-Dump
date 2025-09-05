import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/common/theme/app_colors.dart';

class AuthSignupForm extends StatelessWidget {
  const AuthSignupForm({
    super.key,
    required this.formKey,
    required this.phoneNumController,
    required this.usernameController,
    required this.passwordController,
    required this.hidePassword,
    required this.onTogglePassword,
    required this.agreeToTerms,
    required this.onAgreeToTermsChanged,
    required this.onSignupWithGoogle,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController phoneNumController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  final bool hidePassword;
  final VoidCallback onTogglePassword;

  final bool agreeToTerms;
  final ValueChanged<bool?> onAgreeToTermsChanged;

  final VoidCallback onSignupWithGoogle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: AppColors.darkPurple,
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Sign Up',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),

            // phone number
            TextFormField(
              controller: phoneNumController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              autofillHints: const [AutofillHints.telephoneNumber],
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r"[0-9+\-() ]")),
              ],
              maxLength: 15,
              decoration: InputDecoration(
                hintText: 'Phone number',
                prefixIcon: const Icon(Icons.phone_outlined),
                counterText: '',
                filled: true,
                fillColor: AppColors.lightPurple,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Phone number is required';
                }
                final digits = v.replaceAll(RegExp(r'\\D'), '');
                if (digits.length < 10 || digits.length > 15) {
                  return 'Enter a valid phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            // username
            TextFormField(
              controller: usernameController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'username',
                prefixIcon: const Icon(Icons.person_outline),
                filled: true,
                fillColor: AppColors.lightPurple,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Username is required'
                  : null,
            ),
            const SizedBox(height: 12),
            // password
            TextFormField(
              controller: passwordController,
              obscureText: hidePassword,
              decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: onTogglePassword,
                  icon: Icon(
                    hidePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
                filled: true,
                fillColor: AppColors.lightPurple,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (v) =>
                  (v == null || v.length < 6) ? 'Min 6 characters' : null,
            ),
            const SizedBox(height: 16),

            // divider
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: Text(
                  'or',
                  style: TextStyle(
                    color: AppColors.purpleText,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Google button
            SizedBox(
              height: 52,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: AppColors.blue,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(26),
                    onTap: onSignupWithGoogle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.g_mobiledata_rounded,
                          size: 28,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Sign Up With Google',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // terms
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Checkbox(
                    value: agreeToTerms,
                    visualDensity: VisualDensity.compact,
                    activeColor: AppColors.purple,
                    onChanged: onAgreeToTermsChanged,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: AppColors.purpleText,
                        height: 1.25,
                      ),
                      children: [
                        TextSpan(text: 'I acknowledge and agree to the '),
                        TextSpan(
                          text: 'terms and conditions',
                          style: TextStyle(
                            color: AppColors.orange,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(text: ' from Flutter Demo App'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
