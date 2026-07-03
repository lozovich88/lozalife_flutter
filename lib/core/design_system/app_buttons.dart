import 'package:flutter/material.dart';

/// Primary filled button used to confirm actions in sheets and dialogs.
class AppPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

/// Outlined button with a leading icon (e.g. deadline picker, add column).
class AppOutlinedIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const AppOutlinedIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Icon(icon),
      label: Text(
        label,
        overflow: TextOverflow.ellipsis,
      ),
      onPressed: onPressed,
    );
  }
}

/// Low-emphasis button with a leading icon (e.g. "Add task" in a column).
class AppTextIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const AppTextIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(icon),
      label: Text(label),
      onPressed: onPressed,
    );
  }
}
