import 'package:go_router/go_router.dart';
import 'package:flutter_frontend/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_frontend/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_frontend/features/auth/presentation/screens/signup_screen.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/login',
    routes: <RouteBase>[
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignUpScreen(),
      ),
    ],
  );
}
