import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lozalife/core/design_system/app_sheet.dart';
import 'package:lozalife/features/columns/domain/models/column_model.dart';
import 'package:lozalife/features/tasks/presentation/providers/task_providers.dart';
import 'package:lozalife/features/tasks/presentation/widgets/create_task_sheet.dart';

/// Opens the create-task bottom sheet. [initialColumnId] preselects the
/// column when the sheet is opened from a column's "+" button.
Future<void> showCreateTaskSheet(
  BuildContext context,
  WidgetRef ref, {
  required String boardId,
  required List<ColumnModel> columns,
  String? initialColumnId,
}) async {
  if (columns.isEmpty) {
    return;
  }
  final CreateTaskResult? result = await showAppSheet<CreateTaskResult>(
    context,
    builder: (sheetContext) => CreateTaskSheet(
      columns: columns,
      initialColumnId: initialColumnId ?? columns.first.id,
    ),
  );
  if (result == null) {
    return;
  }
  await ref.read(taskRepositoryProvider).createTask(
        boardId: boardId,
        columnId: result.columnId,
        title: result.title,
        description: result.description,
        deadline: result.deadline,
      );
}
