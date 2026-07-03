import 'package:flutter/material.dart';

/// Standard outlined text field of the app.
class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int maxLines;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.maxLines = 1,
    this.autofocus = false,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      autofocus: autofocus,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        alignLabelWithHint: maxLines > 1,
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
