import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_feed/main.dart';

void main() {
  // Test Case ID: TC006
  testWidgets('SocialFeedApp builds without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const SocialFeedApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
