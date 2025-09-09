import 'package:flutter/material.dart';
import 'package:flutter_application/features/auth/domain/usecase/user_signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  AuthBloc({required UserSignup userSignup})
    : _userSignup = userSignup,
      super(AuthInitial()) {
    on<AuthSignup>((event, emit) async {
      emit(AuthLoading());
      final res = await _userSignup(
        UserSignupParams(
          email: event.email,
          username: event.username,
          password: event.password,
        ),
      );
      res.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (uid) => emit(AuthSuccess(uid)),
      );
    });
  }
}
