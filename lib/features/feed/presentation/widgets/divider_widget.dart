import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final double dividerHeight;
  final double dividerPadding;

  const DividerWidget({
    super.key,
    this.dividerHeight = 3.0,
    this.dividerPadding = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: dividerPadding),
      child: Container(
        height: dividerHeight,
        color: Colors.black26,
      ),
    );
  }
}
