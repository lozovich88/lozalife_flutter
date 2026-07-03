import 'package:flutter/material.dart';

import 'package:lozalife/core/theme/app_dimens.dart';

/// Opens a modal bottom sheet with the app-wide rounded shape.
Future<T?> showAppSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppDimens.sheetRadius),
      ),
    ),
    builder: builder,
  );
}

/// Standard layout for form-like bottom sheets: a title, form fields and
/// a submit button. Handles keyboard insets.
class AppSheetLayout extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final String submitLabel;
  final VoidCallback onSubmit;

  const AppSheetLayout({
    super.key,
    required this.title,
    required this.children,
    required this.submitLabel,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimens.size16,
        right: AppDimens.size16,
        top: AppDimens.size16,
        bottom: MediaQuery.viewInsetsOf(context).bottom + AppDimens.size16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppDimens.size16),
          ...children,
          const SizedBox(height: AppDimens.size16),
          FilledButton(
            onPressed: onSubmit,
            child: Text(submitLabel),
          ),
        ],
      ),
    );
  }
}
