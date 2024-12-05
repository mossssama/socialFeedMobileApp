import 'package:flutter/material.dart';

class RoundedCornerColoredButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  const RoundedCornerColoredButtonWidget({super.key, required this.title, required this.onPressed, this.backgroundColor = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: Colors.white,
          ),
          child: Text(title),
        ));
  }
}
