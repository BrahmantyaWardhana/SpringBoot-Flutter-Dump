import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_application/common/error/snackbar_error.dart';
import 'package:flutter_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_application/features/auth/presentation/widgets/auth_header.dart';
import 'package:flutter_application/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:flutter_application/features/auth/presentation/widgets/auth_login_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Form state owned by the page
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool _hidePwd = true;
  bool _agreeToTerms = false;
  bool _submitting = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() != true) return;
    context.read<AuthBloc>().add(
      AuthLogin(
        email: _emailCtrl.text.trim(),
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
          snackbarError(context, state.message);
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
                AuthLoginInForm(
                  formKey: _formKey,
                  emailController: _emailCtrl,
                  passwordController: _passwordCtrl,
                  hidePassword: _hidePwd,
                  onTogglePassword: () => setState(() => _hidePwd = !_hidePwd),
                  agreeToTerms: _agreeToTerms,
                  onAgreeToTermsChanged: (v) =>
                      setState(() => _agreeToTerms = v ?? false),
                  onLoginWithGoogle: () {}, // IMPLEMENT GOOGLE LOGIN
                ),
                const SizedBox(height: 28),
                RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 231, 188, 87),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.push('/signup'),
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
              isLoading: _submitting,
              onPressed: _handleSubmit,
            ),
          ),
        ),
      ),
    );
  }
}
