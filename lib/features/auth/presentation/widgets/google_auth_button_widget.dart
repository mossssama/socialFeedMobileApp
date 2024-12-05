import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GoogleAuthenticationButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const GoogleAuthenticationButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton.icon(
        icon: Icon(MdiIcons.google),
        label: Align(
          alignment: Alignment.centerLeft,
          child: Text(title),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[200],
          foregroundColor: Colors.black,
        ),
      ),
    );
  }
}
