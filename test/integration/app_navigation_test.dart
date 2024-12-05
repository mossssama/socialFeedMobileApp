import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_feed/features/auth/presentation/screens/login_screen.dart';
import 'package:social_feed/firebase_options.dart';
import 'package:social_feed/main.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Ensure Firebase is initialized for the test
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  // Test Case ID: TC001
  testWidgets('App navigates to initial route based on authentication state', (WidgetTester tester) async {
    // Simulate a logged-out state by ensuring no user is signed in
    await FirebaseAuth.instance.signOut();

    // Build the app and trigger a frame
    await tester.pumpWidget(const SocialFeedApp());

    // Verify that the login screen is shown
    expect(find.byType(LoginScreen), findsOneWidget);

    // Simulate a logged-in state by signing in a user
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'testuser@example.com',
      password: 'password123',
    );

    // Rebuild the app
    await tester.pumpWidget(const SocialFeedApp());

    // Verify that the main screen is shown
    expect(find.byType(MainScreen), findsOneWidget);
  });
}
