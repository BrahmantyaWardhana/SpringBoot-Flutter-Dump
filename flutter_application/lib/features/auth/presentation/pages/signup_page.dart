import 'package:flutter/material.dart';
import 'package:flutter_application/features/auth/presentation/widgets/auth_header.dart';
import 'package:flutter_application/features/auth/presentation/widgets/auth_signup_cta.dart';
import 'package:flutter_application/features/auth/presentation/widgets/auth_signup_form.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Form state owned by the page
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool _hidePwd = true;
  bool _agreeToTerms = false;
  bool _submitting = false;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    FocusScope.of(context).unfocus();

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the terms first.')),
      );
      return;
    }

    if (_formKey.currentState?.validate() != true) return;

    setState(() => _submitting = true);
    try {
      // TODO: Call your signup API here using:
      // _usernameCtrl.text, _passwordCtrl.text
      // If success -> navigate
      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return;
      context.go('/');
    } finally {
      if (!mounted) return;
      setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            children: [
              const SizedBox(height: 8),
              // header
              const AuthHeader(),
              // form container
              AuthSignupForm(
                formKey: _formKey,
                usernameController: _usernameCtrl,
                passwordController: _passwordCtrl,
                hidePassword: _hidePwd,
                onTogglePassword: () => setState(() => _hidePwd = !_hidePwd),
                agreeToTerms: _agreeToTerms,
                onAgreeToTermsChanged: (v) =>
                    setState(() => _agreeToTerms = v ?? false),
                onLoginWithGoogle: () {}, // IMPLEMENT GOOGLE LOGIN
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: SizedBox(
          height: 56,
          child: AuthSignupCta(
            loading: _submitting,
            onPressed: _submitting ? null : _handleSubmit,
          ),
        ),
      ),
    );
  }
}
