import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_application/features/auth/presentation/widgets/auth_header.dart';
import 'package:flutter_application/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:flutter_application/features/auth/presentation/widgets/auth_signup_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool _hidePwd = true;
  bool _agreeToTerms = false;
  bool _submitting = false;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    _emailCtrl.dispose();
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
    context.read<AuthBloc>().add(
      AuthSignup(
        email: _emailCtrl.text.trim(),
        username: _usernameCtrl.text.trim(),
        password: _passwordCtrl.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(() => _submitting = true);
        } else {
          if (_submitting) setState(() => _submitting = false);
        }
        if (state is AuthSuccess) {
          context.go('/');
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
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
                  emailController: _emailCtrl,
                  usernameController: _usernameCtrl,
                  passwordController: _passwordCtrl,
                  hidePassword: _hidePwd,
                  onTogglePassword: () => setState(() => _hidePwd = !_hidePwd),
                  agreeToTerms: _agreeToTerms,
                  onAgreeToTermsChanged: (v) =>
                      setState(() => _agreeToTerms = v ?? false),
                  onSignupWithGoogle: () {}, // IMPLEMENT GOOGLE LOGIN
                ),
                const SizedBox(height: 28),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 231, 188, 87),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.push('/login'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: SizedBox(
            height: 56,
            child: AuthSubmitButton(
              loading: _submitting,
              onPressed: _submitting ? null : _handleSubmit,
            ),
          ),
        ),
      ),
    );
  }
}
