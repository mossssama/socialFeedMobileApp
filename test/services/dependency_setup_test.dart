import 'package:flutter_test/flutter_test.dart';
import 'package:social_feed/core/firebase_client.dart';
import 'package:social_feed/core/get_it.dart';
import 'package:social_feed/features/feed/presentation/controllers/feeds_cubit.dart';

void main() {
  // Test Case ID: TC004
  test('Dependencies are initialized correctly', () {
    // Call the dependency setup function
    setupDependencies();

    // Verify that dependencies are registered
    expect(getIt.isRegistered<FeedsCubit>(), true);
    expect(getIt.isRegistered<FirebaseClient>(), true);
  });
}
