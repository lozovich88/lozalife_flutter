import 'package:flutter/material.dart';

import 'package:lozalife/core/localization/l10n.dart';

/// A single action button of [showAppDecisionDialog].
class AppDialogAction<T> {
  final T value;
  final String label;
  final bool isPrimary;

  const AppDialogAction({
    required this.value,
    required this.label,
    this.isPrimary = false,
  });
}

/// Dialog with a title, an optional message and custom actions.
/// A "Cancel" button that pops null is always added first.
Future<T?> showAppDecisionDialog<T>(
  BuildContext context, {
  required String title,
  String? message,
  required List<AppDialogAction<T>> actions,
}) {
  return showDialog<T>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: message == null ? null : Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(dialogContext.l10n.cancelAction),
        ),
        for (final AppDialogAction<T> action in actions)
          if (action.isPrimary)
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(action.value),
              child: Text(action.label),
            )
          else
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(action.value),
              child: Text(action.label),
            ),
      ],
    ),
  );
}

/// Confirmation dialog. Returns true when the user confirms.
Future<bool> showAppConfirmDialog(
  BuildContext context, {
  required String title,
  String? message,
  required String confirmLabel,
}) async {
  final bool? confirmed = await showAppDecisionDialog<bool>(
    context,
    title: title,
    message: message,
    actions: [
      AppDialogAction(value: true, label: confirmLabel, isPrimary: true),
    ],
  );
  return confirmed ?? false;
}

/// Dialog with a single name field (e.g. create/rename column).
/// Returns the trimmed name or null when dismissed.
Future<String?> showAppNameDialog(
  BuildContext context, {
  required String title,
  required String confirmLabel,
  String? initialValue,
}) {
  final TextEditingController controller =
      TextEditingController(text: initialValue);
  return showDialog<String>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: InputDecoration(labelText: dialogContext.l10n.nameLabel),
        onSubmitted: (value) => Navigator.of(dialogContext).pop(value.trim()),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(dialogContext.l10n.cancelAction),
        ),
        FilledButton(
          onPressed: () =>
              Navigator.of(dialogContext).pop(controller.text.trim()),
          child: Text(confirmLabel),
        ),
      ],
    ),
  ).whenComplete(controller.dispose);
}

/// A single option of [showAppChoiceDialog].
class AppChoiceOption<T> {
  final T value;
  final String label;

  const AppChoiceOption({
    required this.value,
    required this.label,
  });
}

/// Dialog with a vertical list of options (e.g. picking a target column).
/// Returns the picked value or null.
Future<T?> showAppChoiceDialog<T>(
  BuildContext context, {
  required String title,
  required List<AppChoiceOption<T>> options,
}) {
  return showDialog<T>(
    context: context,
    builder: (dialogContext) => SimpleDialog(
      title: Text(title),
      children: options
          .map(
            (option) => SimpleDialogOption(
              onPressed: () => Navigator.of(dialogContext).pop(option.value),
              child: Text(option.label),
            ),
          )
          .toList(),
    ),
  );
}
