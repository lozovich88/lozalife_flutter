import 'package:flutter/material.dart';

/// A single entry of [showAppActionsSheet].
class AppSheetAction<T> {
  final T value;
  final IconData icon;
  final String label;

  const AppSheetAction({
    required this.value,
    required this.icon,
    required this.label,
  });
}

/// Opens a bottom sheet with a vertical list of actions (e.g. the swipe
/// menu of a board card). Returns the picked value or null.
Future<T?> showAppActionsSheet<T>(
  BuildContext context, {
  required List<AppSheetAction<T>> actions,
}) {
  return showModalBottomSheet<T>(
    context: context,
    builder: (sheetContext) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: actions
            .map(
              (action) => ListTile(
                leading: Icon(action.icon),
                title: Text(action.label),
                onTap: () => Navigator.of(sheetContext).pop(action.value),
              ),
            )
            .toList(),
      ),
    ),
  );
}
