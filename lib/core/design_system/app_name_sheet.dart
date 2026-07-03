import 'package:flutter/material.dart';

import 'package:lozalife/core/design_system/app_sheet.dart';
import 'package:lozalife/core/design_system/app_text_field.dart';
import 'package:lozalife/core/localization/l10n.dart';

/// Opens a bottom sheet with a single name field.
///
/// Returns the trimmed name or null when dismissed. Used for creating and
/// renaming boards.
Future<String?> showAppNameSheet(
  BuildContext context, {
  required String title,
  required String confirmLabel,
  String? initialValue,
}) {
  return showAppSheet<String>(
    context,
    builder: (sheetContext) => _NameSheet(
      title: title,
      confirmLabel: confirmLabel,
      initialValue: initialValue,
    ),
  );
}

class _NameSheet extends StatefulWidget {
  final String title;
  final String confirmLabel;
  final String? initialValue;

  const _NameSheet({
    required this.title,
    required this.confirmLabel,
    this.initialValue,
  });

  @override
  State<_NameSheet> createState() => _NameSheetState();
}

class _NameSheetState extends State<_NameSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final String name = _controller.text.trim();
    if (name.isEmpty) {
      return;
    }
    Navigator.of(context).pop(name);
  }

  @override
  Widget build(BuildContext context) {
    return AppSheetLayout(
      title: widget.title,
      submitLabel: widget.confirmLabel,
      onSubmit: _submit,
      children: [
        AppTextField(
          controller: _controller,
          label: context.l10n.nameLabel,
          autofocus: true,
          textInputAction: TextInputAction.done,
          onSubmitted: (value) => _submit(),
        ),
      ],
    );
  }
}
