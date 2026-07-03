import 'package:flutter/material.dart';

/// Outlined button that opens a date picker and reports the chosen date.
///
/// Shows [placeholder] when [value] is null, otherwise the formatted date.
class AppDatePickerButton extends StatelessWidget {
  static const int _yearsBack = 1;
  static const int _yearsAhead = 5;

  final DateTime? value;
  final String placeholder;
  final ValueChanged<DateTime> onPicked;

  const AppDatePickerButton({
    super.key,
    required this.value,
    required this.placeholder,
    required this.onPicked,
  });

  Future<void> _pick(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: value ?? now,
      firstDate: DateTime(now.year - _yearsBack),
      lastDate: DateTime(now.year + _yearsAhead),
    );
    if (picked != null) {
      onPicked(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime? currentValue = value;
    return OutlinedButton.icon(
      icon: const Icon(Icons.event),
      label: Text(
        currentValue == null
            ? placeholder
            : MaterialLocalizations.of(context).formatShortDate(currentValue),
      ),
      onPressed: () => _pick(context),
    );
  }
}
