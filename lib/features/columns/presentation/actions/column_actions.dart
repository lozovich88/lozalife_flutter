import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lozalife/core/design_system/app_dialogs.dart';
import 'package:lozalife/core/localization/l10n.dart';
import 'package:lozalife/features/columns/domain/models/column_model.dart';
import 'package:lozalife/features/columns/presentation/providers/column_providers.dart';

/// Prompts for a name and creates a new column at the end of the board.
Future<void> showCreateColumnDialog(
  BuildContext context,
  WidgetRef ref,
  String boardId,
) async {
  final String? name = await showAppNameDialog(
    context,
    title: context.l10n.newColumnTitle,
    confirmLabel: context.l10n.createAction,
  );
  if (name == null || name.isEmpty) {
    return;
  }
  await ref.read(columnRepositoryProvider).createColumn(boardId, name);
}

/// Prompts for a new name for an existing column.
Future<void> showRenameColumnDialog(
  BuildContext context,
  WidgetRef ref,
  ColumnModel column,
) async {
  final String? name = await showAppNameDialog(
    context,
    title: context.l10n.renameColumnTitle,
    confirmLabel: context.l10n.saveAction,
    initialValue: column.name,
  );
  if (name == null || name.isEmpty) {
    return;
  }
  await ref.read(columnRepositoryProvider).renameColumn(column.id, name);
}

/// Deletes a column. Empty columns are deleted right away; for non-empty
/// ones the user chooses between deleting the tasks or moving them to
/// another column.
Future<void> showDeleteColumnFlow(
  BuildContext context,
  WidgetRef ref, {
  required ColumnModel column,
  required int taskCount,
  required List<ColumnModel> otherColumns,
}) async {
  if (taskCount == 0) {
    await ref
        .read(columnRepositoryProvider)
        .deleteColumn(column.id, deleteTasks: false);
    return;
  }

  final _DeleteChoice? choice = await showAppDecisionDialog<_DeleteChoice>(
    context,
    title: context.l10n.deleteColumnQuestion(column.name),
    message: context.l10n.columnContainsTasks(taskCount),
    actions: [
      if (otherColumns.isNotEmpty)
        AppDialogAction(
          value: _DeleteChoice.moveTasks,
          label: context.l10n.moveTasksAction,
        ),
      AppDialogAction(
        value: _DeleteChoice.deleteWithTasks,
        label: context.l10n.deleteWithTasksAction,
        isPrimary: true,
      ),
    ],
  );

  switch (choice) {
    case _DeleteChoice.deleteWithTasks:
      await ref
          .read(columnRepositoryProvider)
          .deleteColumn(column.id, deleteTasks: true);
    case _DeleteChoice.moveTasks:
      if (context.mounted) {
        await _pickTargetAndMove(context, ref, column, otherColumns);
      }
    case null:
      break;
  }
}

Future<void> _pickTargetAndMove(
  BuildContext context,
  WidgetRef ref,
  ColumnModel column,
  List<ColumnModel> otherColumns,
) async {
  final String? targetColumnId = await showAppChoiceDialog<String>(
    context,
    title: context.l10n.moveTasksToTitle,
    options: otherColumns
        .map(
          (candidate) => AppChoiceOption(
            value: candidate.id,
            label: candidate.name,
          ),
        )
        .toList(),
  );
  if (targetColumnId == null) {
    return;
  }
  await ref
      .read(columnRepositoryProvider)
      .deleteColumnMovingTasks(column.id, targetColumnId);
}

enum _DeleteChoice { deleteWithTasks, moveTasks }
