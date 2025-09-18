part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignup extends AuthEvent {
  final String email;
  final String username;
  final String password;

  AuthSignup({
    required this.email,
    required this.username,
    required this.password,
  });
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});
}

final class AuthIsUserLoggedIn extends AuthEvent {}
