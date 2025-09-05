import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/auth/presentation/pages/signup_page.dart';
import 'features/home/presentation/pages/home_page.dart';

// Centralized app router configuration using go_router.
final GoRouter router = GoRouter(
  initialLocation: '/signup',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) => const HomePage(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (BuildContext context, GoRouterState state) =>
          const SignupPage(),
    ),
  ],
);
