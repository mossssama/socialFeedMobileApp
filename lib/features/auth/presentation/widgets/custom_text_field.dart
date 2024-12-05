import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? minLengthValidation;
  final RegexValidation? regexValidation;
  final GlobalKey<FormState> validationKey;
  final TextEditingController? listenedController;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.minLengthValidation = 6,
    this.obscureText = false,
    this.suffixIcon,
    this.regexValidation,
    this.listenedController,
    required this.validationKey,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (val) {
        if (val!.isEmpty) return 'Can\'t be Empty';
        if (widget.listenedController != null && val != widget.listenedController!.text) {
          return 'Not Matching';
        }
        if (widget.regexValidation != null && !RegExp(widget.regexValidation!.validationValue).hasMatch(val)) {
          return widget.regexValidation!.validationError;
        }
        if (val.length < widget.minLengthValidation!) {
          return "${widget.label} should be at least ${widget.minLengthValidation} characters";
        }
        return null;
      },
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        suffixIcon: (widget.suffixIcon != null)
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null,
      ),
      onChanged: (currentValue) {
        // widget.validationKey.currentState!.validate();   // To add its logic futurely
      },
    );
  }
}

class RegexValidation {
  final String validationValue;
  final String validationError;

  const RegexValidation({required this.validationError, required this.validationValue});
}
