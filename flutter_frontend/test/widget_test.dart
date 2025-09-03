// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_frontend/app/app.dart';

void main() {
  testWidgets('Login -> Home flow', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();

    // Login is initial
    expect(find.text('Login'), findsOneWidget);

    // Go to Sign Up
    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();
    expect(find.text('Sign Up'), findsOneWidget);

    // Complete Sign Up and land on Home
    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
  });
}
