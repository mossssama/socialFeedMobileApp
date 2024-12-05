import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_feed/core/constants.dart';
import 'package:social_feed/features/feed/presentation/screens/feeds_screen.dart';
import 'package:social_feed/features/profile/presentation/screens/profile_screen.dart';
import 'package:social_feed/main.dart';

void main() {
  // Test Case ID: TC002
  testWidgets('Bottom navigation switches tabs correctly', (WidgetTester tester) async {
    // Build the MainScreen widget
    await tester.pumpWidget(const MaterialApp(home: MainScreen()));

    // Verify that the FeedsScreen is displayed initially
    expect(find.byType(FeedsScreen), findsOneWidget);
    expect(find.byType(ProfileScreen), findsNothing);

    // Tap the Profile tab
    await tester.tap(find.byIcon(Icons.person_2_outlined));
    await tester.pump();

    // Verify that the ProfileScreen is displayed
    expect(find.byType(FeedsScreen), findsNothing);
    expect(find.byType(ProfileScreen), findsOneWidget);
  });

  // Test Case ID: TC003
  testWidgets('AppBar title changes based on selected tab', (WidgetTester tester) async {
    // Build the MainScreen widget
    await tester.pumpWidget(const MaterialApp(home: MainScreen()));

    // Verify that the AppBar title is Feeds
    expect(find.text(feedsTabName), findsOneWidget);
    expect(find.text(profileTabName), findsNothing);

    // Tap the Profile tab
    await tester.tap(find.byIcon(Icons.person_2_outlined));
    await tester.pump();

    // Verify that the AppBar title is Profile
    expect(find.text(feedsTabName), findsNothing);
    expect(find.text(profileTabName), findsOneWidget);
  });

  // Test Case ID: TC007
  testWidgets('BottomNavigationBar displays active labels', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainScreen()));

    // Verify that Feeds label is shown by default
    expect(find.text(feedsTabName), findsOneWidget);

    // Tap the Profile tab
    await tester.tap(find.byIcon(Icons.person_2_outlined));
    await tester.pump();

    // Verify that Profile label is shown
    expect(find.text(profileTabName), findsOneWidget);
  });
}
