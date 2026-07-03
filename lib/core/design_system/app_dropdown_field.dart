import 'package:flutter/material.dart';

/// Option shown by [AppDropdownField].
class AppDropdownOption<T> {
  final T value;
  final String label;

  const AppDropdownOption({
    required this.value,
    required this.label,
  });
}

/// Standard outlined dropdown of the app (e.g. column picker).
class AppDropdownField<T> extends StatelessWidget {
  final String label;
  final T value;
  final List<AppDropdownOption<T>> options;
  final ValueChanged<T> onChanged;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: options
          .map(
            (option) => DropdownMenuItem(
              value: option.value,
              child: Text(
                option.label,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      onChanged: (selected) {
        if (selected != null) {
          onChanged(selected);
        }
      },
    );
  }
}
