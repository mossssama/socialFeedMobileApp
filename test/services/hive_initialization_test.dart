import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:social_feed/core/constants.dart';

void main() {
  // Test Case ID: TC005
  test('Hive boxes are initialized and cleared', () async {
    await Hive.initFlutter();
    await Hive.openBox(hiveFeedCacheBox);
    await Hive.openBox(hiveProfileCacheBox);

    // Clear boxes
    await Hive.box(hiveFeedCacheBox).clear();
    await Hive.box(hiveProfileCacheBox).clear();

    // Verify that the boxes are empty
    expect(Hive.box(hiveFeedCacheBox).isEmpty, true);
    expect(Hive.box(hiveProfileCacheBox).isEmpty, true);
  });
}
