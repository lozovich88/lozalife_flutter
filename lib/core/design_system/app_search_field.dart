import 'package:flutter/material.dart';

import 'package:lozalife/core/theme/app_dimens.dart';

/// Standard search input of the app with a clear button.
class AppSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const AppSearchField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.size16,
        vertical: AppDimens.size8,
      ),
      child: SearchBar(
        controller: controller,
        hintText: hint,
        leading: const Icon(Icons.search),
        trailing: [
          if (controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: onClear,
            ),
        ],
        onChanged: onChanged,
      ),
    );
  }
}
