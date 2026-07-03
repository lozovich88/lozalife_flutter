import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lozalife/core/design_system/app_buttons.dart';
import 'package:lozalife/core/localization/l10n.dart';
import 'package:lozalife/core/theme/app_dimens.dart';
import 'package:lozalife/features/columns/domain/models/column_model.dart';
import 'package:lozalife/features/columns/presentation/actions/column_actions.dart';
import 'package:lozalife/features/columns/presentation/widgets/column_drop_zone.dart';
import 'package:lozalife/features/tasks/domain/models/task_model.dart';
import 'package:lozalife/features/tasks/presentation/actions/task_actions.dart';
import 'package:lozalife/features/tasks/presentation/providers/task_providers.dart';
import 'package:lozalife/features/tasks/presentation/widgets/draggable_task_card.dart';

/// A single board column: header with name and task count, the task list
/// with drag&drop support and a button for adding a task.
///
/// Watches only its own tasks, so changes in other columns do not rebuild it.
class BoardColumn extends ConsumerWidget {
  final ColumnModel column;
  final List<ColumnModel> allColumns;

  const BoardColumn({
    super.key,
    required this.column,
    required this.allColumns,
  });

  Future<void> _onTaskDropped(
    WidgetRef ref,
    TaskModel task,
    int targetIndex,
  ) =>
      ref.read(taskRepositoryProvider).moveTask(
            taskId: task.id,
            targetColumnId: column.id,
            targetIndex: targetIndex,
          );

  void _onMenuAction(
    BuildContext context,
    WidgetRef ref,
    _ColumnMenuAction action,
    int taskCount,
  ) {
    switch (action) {
      case _ColumnMenuAction.rename:
        showRenameColumnDialog(context, ref, column);
      case _ColumnMenuAction.delete:
        showDeleteColumnFlow(
          context,
          ref,
          column: column,
          taskCount: taskCount,
          otherColumns: allColumns
              .where((candidate) => candidate.id != column.id)
              .toList(),
        );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<TaskModel> tasks = ref.watch(
      columnTasksProvider((boardId: column.boardId, columnId: column.id)),
    );
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: AppDimens.boardColumnWidth,
      child: Card(
        color: colorScheme.surfaceContainerLow,
        margin: const EdgeInsets.all(AppDimens.size8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ColumnHeader(
              name: column.name,
              taskCount: tasks.length,
              onMenuAction: (action) =>
                  _onMenuAction(context, ref, action, tasks.length),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: AppDimens.size8),
                // One extra slot: the tail drop zone that accepts drops
                // below the last task.
                itemCount: tasks.length + 1,
                itemBuilder: (listContext, index) {
                  if (index == tasks.length) {
                    return ColumnDropZone(
                      isTail: true,
                      onAccept: (task) => _onTaskDropped(ref, task, index),
                    );
                  }
                  return ColumnDropZone(
                    onAccept: (task) => _onTaskDropped(ref, task, index),
                    child: DraggableTaskCard(task: tasks[index]),
                  );
                },
              ),
            ),
            _AddTaskButton(
              onPressed: () => showCreateTaskSheet(
                context,
                ref,
                boardId: column.boardId,
                columns: allColumns,
                initialColumnId: column.id,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColumnHeader extends StatelessWidget {
  final String name;
  final int taskCount;
  final ValueChanged<_ColumnMenuAction> onMenuAction;

  const _ColumnHeader({
    required this.name,
    required this.taskCount,
    required this.onMenuAction,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: AppDimens.size16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: textTheme.titleSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.size8),
            child: Text(
              '$taskCount',
              style: textTheme.labelMedium,
            ),
          ),
          PopupMenuButton<_ColumnMenuAction>(
            onSelected: onMenuAction,
            itemBuilder: (menuContext) => [
              PopupMenuItem(
                value: _ColumnMenuAction.rename,
                child: Text(menuContext.l10n.renameAction),
              ),
              PopupMenuItem(
                value: _ColumnMenuAction.delete,
                child: Text(menuContext.l10n.deleteAction),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddTaskButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddTaskButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.size8),
      child: AppTextIconButton(
        icon: Icons.add,
        label: context.l10n.addTaskAction,
        onPressed: onPressed,
      ),
    );
  }
}

enum _ColumnMenuAction { rename, delete }
