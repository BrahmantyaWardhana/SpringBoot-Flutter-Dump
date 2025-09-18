import 'package:flutter/material.dart';
import 'package:flutter_application/common/usecase/usecase.dart';
import 'package:flutter_application/features/auth/domain/entities/user.dart';
import 'package:flutter_application/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_application/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_application/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;

  AuthBloc({
    required UserSignup userSignup,
    required UserLogin userLogin,
    required CurrentUser currentUser,
  }) : _userSignup = userSignup,
       _userLogin = userLogin,
       _currentUser = currentUser,
       super(AuthInitial()) {
    on<AuthSignup>(_onAuthSignup);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _onAuthSignup(AuthSignup event, Emitter<AuthState> emit) async {
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
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin(
      UserLoginParams(email: event.email, password: event.password),
    );
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (success) => emit(AuthSuccess(success)),
    );
  }
}
