import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachedImageProgressIndicator extends StatelessWidget {
  const CachedImageProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 216, 216, 216),
        highlightColor: const Color.fromARGB(255, 255, 255, 255),
        child: Container(
          color: Colors.amber,
        ));
  }
}
