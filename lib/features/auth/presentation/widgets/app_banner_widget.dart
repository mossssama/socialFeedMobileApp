import 'package:flutter/material.dart';

import '../../../../core/constants.dart';

class AppBannerWidget extends StatelessWidget {
  const AppBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [const SizedBox(height: 8), Image.asset(appIcon), const SizedBox(height: 4), const Text("by Mohamed Osama", style: TextStyle(color: Colors.grey))],
      ),
    );
  }
}
