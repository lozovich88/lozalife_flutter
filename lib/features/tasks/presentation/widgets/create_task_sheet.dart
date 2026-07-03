import 'package:flutter/material.dart';

import 'package:lozalife/core/design_system/app_date_picker_button.dart';
import 'package:lozalife/core/design_system/app_dropdown_field.dart';
import 'package:lozalife/core/design_system/app_sheet.dart';
import 'package:lozalife/core/design_system/app_text_field.dart';
import 'package:lozalife/core/localization/l10n.dart';
import 'package:lozalife/core/theme/app_dimens.dart';
import 'package:lozalife/features/columns/domain/models/column_model.dart';

/// Values collected by [CreateTaskSheet].
class CreateTaskResult {
  final String title;
  final String? description;
  final DateTime? deadline;
  final String columnId;

  const CreateTaskResult({
    required this.title,
    required this.description,
    required this.deadline,
    required this.columnId,
  });
}

/// Bottom sheet with title, description, deadline and target column.
class CreateTaskSheet extends StatefulWidget {
  final List<ColumnModel> columns;
  final String initialColumnId;

  const CreateTaskSheet({
    super.key,
    required this.columns,
    required this.initialColumnId,
  });

  @override
  State<CreateTaskSheet> createState() => _CreateTaskSheetState();
}

class _CreateTaskSheetState extends State<CreateTaskSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _deadline;
  late String _columnId = widget.initialColumnId;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    final String title = _titleController.text.trim();
    if (title.isEmpty) {
      return;
    }
    final String description = _descriptionController.text.trim();
    Navigator.of(context).pop(
      CreateTaskResult(
        title: title,
        description: description.isEmpty ? null : description,
        deadline: _deadline,
        columnId: _columnId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppSheetLayout(
      title: context.l10n.newTaskTitle,
      submitLabel: context.l10n.createAction,
      onSubmit: _submit,
      children: [
        AppTextField(
          controller: _titleController,
          label: context.l10n.titleLabel,
          autofocus: true,
        ),
        const SizedBox(height: AppDimens.size12),
        AppTextField(
          controller: _descriptionController,
          label: context.l10n.descriptionLabel,
          maxLines: AppDimens.taskDescriptionMaxLines,
        ),
        const SizedBox(height: AppDimens.size12),
        Row(
          children: [
            Expanded(
              child: AppDatePickerButton(
                value: _deadline,
                placeholder: context.l10n.deadlineLabel,
                onPicked: (picked) => setState(() => _deadline = picked),
              ),
            ),
            const SizedBox(width: AppDimens.size12),
            Expanded(
              child: AppDropdownField<String>(
                label: context.l10n.columnLabel,
                value: _columnId,
                options: widget.columns
                    .map(
                      (column) => AppDropdownOption(
                        value: column.id,
                        label: column.name,
                      ),
                    )
                    .toList(),
                onChanged: (selected) => setState(() => _columnId = selected),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
