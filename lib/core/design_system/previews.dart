import 'package:flutter/material.dart';

import 'package:lozalife/core/design_system/app_async_states.dart';
import 'package:lozalife/core/design_system/app_buttons.dart';
import 'package:lozalife/core/design_system/app_card.dart';
import 'package:lozalife/core/design_system/app_date_picker_button.dart';
import 'package:lozalife/core/design_system/app_deadline_chip.dart';
import 'package:lozalife/core/design_system/app_dropdown_field.dart';
import 'package:lozalife/core/design_system/app_search_field.dart';
import 'package:lozalife/core/design_system/app_sheet.dart';
import 'package:lozalife/core/design_system/app_text_field.dart';
import 'package:lozalife/core/theme/app_dimens.dart';
import 'package:lozalife/shared/previews/app_preview.dart';

/// Widget previews for the design system.
///
/// Run with `flutter widget-preview start`.

const String _group = 'Design system';

@AppPreview(name: 'Buttons', group: _group, size: Size(280, 200))
Widget buttonsPreview() => Padding(
      padding: const EdgeInsets.all(AppDimens.size16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppPrimaryButton(label: 'Create', onPressed: () {}),
          const SizedBox(height: AppDimens.size8),
          AppOutlinedIconButton(
            icon: Icons.add,
            label: 'Add column',
            onPressed: () {},
          ),
          const SizedBox(height: AppDimens.size8),
          AppTextIconButton(
            icon: Icons.add,
            label: 'Add task',
            onPressed: () {},
          ),
        ],
      ),
    );

@AppPreview(name: 'Text field', group: _group, size: Size(320, 100))
Widget textFieldPreview() => Padding(
      padding: const EdgeInsets.all(AppDimens.size16),
      child: AppTextField(
        controller: TextEditingController(text: 'Prepare launch checklist'),
        label: 'Title',
      ),
    );

@AppPreview(name: 'Text field — multiline', group: _group, size: Size(320, 160))
Widget multilineTextFieldPreview() => Padding(
      padding: const EdgeInsets.all(AppDimens.size16),
      child: AppTextField(
        controller: TextEditingController(),
        label: 'Description',
        maxLines: 3,
      ),
    );

@AppPreview(name: 'Dropdown field', group: _group, size: Size(320, 100))
Widget dropdownFieldPreview() => Padding(
      padding: const EdgeInsets.all(AppDimens.size16),
      child: AppDropdownField<String>(
        label: 'Column',
        value: 'todo',
        options: const [
          AppDropdownOption(value: 'todo', label: 'To Do'),
          AppDropdownOption(value: 'progress', label: 'In Progress'),
          AppDropdownOption(value: 'done', label: 'Done'),
        ],
        onChanged: (value) {},
      ),
    );

@AppPreview(name: 'Date picker button', group: _group, size: Size(320, 130))
Widget datePickerButtonPreview() => Padding(
      padding: const EdgeInsets.all(AppDimens.size16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppDatePickerButton(
            value: null,
            placeholder: 'Deadline',
            onPicked: (picked) {},
          ),
          const SizedBox(height: AppDimens.size8),
          AppDatePickerButton(
            value: DateTime(2026, 7, 20),
            placeholder: 'Deadline',
            onPicked: (picked) {},
          ),
        ],
      ),
    );

@AppPreview(name: 'Card', group: _group, size: Size(320, 120))
Widget cardPreview() => Padding(
      padding: const EdgeInsets.all(AppDimens.size16),
      child: AppCard(
        onTap: () {},
        child: const Text('Tappable card content'),
      ),
    );

@AppPreview(name: 'Deadline chip', group: _group, size: Size(320, 90))
Widget deadlineChipPreview() => Padding(
      padding: const EdgeInsets.all(AppDimens.size16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppDeadlineChip(deadline: DateTime(2030, 1, 15)),
          const SizedBox(height: AppDimens.size8),
          // Past date renders in the error color.
          AppDeadlineChip(deadline: DateTime(2020, 1, 15)),
        ],
      ),
    );

@AppPreview(name: 'Search field', group: _group, size: Size(360, 90))
Widget searchFieldPreview() => AppSearchField(
      controller: TextEditingController(),
      hint: 'Search tasks',
      onChanged: (value) {},
      onClear: () {},
    );

@AppPreview(name: 'Sheet layout', group: _group, size: Size(360, 260))
Widget sheetLayoutPreview() => AppSheetLayout(
      title: 'New board',
      submitLabel: 'Create',
      onSubmit: () {},
      children: [
        AppTextField(
          controller: TextEditingController(),
          label: 'Name',
        ),
      ],
    );

@AppPreview(name: 'Loading state', group: _group, size: Size(320, 120))
Widget loadingStatePreview() => const AppLoadingState();

@AppPreview(name: 'Error state', group: _group, size: Size(320, 120))
Widget errorStatePreview() =>
    const AppErrorState(message: 'Failed to load boards: connection lost');

@AppPreview(name: 'Empty state', group: _group, size: Size(320, 120))
Widget emptyStatePreview() =>
    const AppEmptyState(message: 'No boards yet.\nTap + to create one.');
