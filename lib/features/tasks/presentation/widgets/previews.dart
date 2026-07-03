import 'package:flutter/material.dart';

import 'package:lozalife/features/tasks/presentation/screens/task_screen.dart';
import 'package:lozalife/features/tasks/presentation/widgets/create_task_sheet.dart';
import 'package:lozalife/features/tasks/presentation/widgets/draggable_task_card.dart';
import 'package:lozalife/features/tasks/presentation/widgets/task_card.dart';
import 'package:lozalife/shared/previews/app_preview.dart';
import 'package:lozalife/shared/previews/preview_data.dart';

/// Widget previews for the tasks feature.
///
/// Run with `flutter widget-preview start`.

const String _group = 'Tasks';

@AppPreview(name: 'Task card — full', group: _group, size: Size(320, 160))
Widget taskCardPreview() => TaskCard(task: previewTasks.first);

@AppPreview(name: 'Task card — title only', group: _group, size: Size(320, 90))
Widget minimalTaskCardPreview() => TaskCard(task: previewTasks[1]);

@AppPreview(name: 'Task card — overdue', group: _group, size: Size(320, 150))
Widget overdueTaskCardPreview() => TaskCard(task: previewTasks[2]);

@AppPreview(name: 'Draggable task card', group: _group, size: Size(320, 160))
Widget draggableTaskCardPreview() =>
    DraggableTaskCard(task: previewTasks.first);

@AppPreview(name: 'Create task sheet', group: _group, size: Size(400, 380))
Widget createTaskSheetPreview() => CreateTaskSheet(
      columns: previewColumns,
      initialColumnId: previewColumns.first.id,
    );

@AppPreview(name: 'Task screen', group: 'Screens', size: Size(500, 700))
Widget taskScreenPreview() => TaskScreen(taskId: previewTasks.first.id);
