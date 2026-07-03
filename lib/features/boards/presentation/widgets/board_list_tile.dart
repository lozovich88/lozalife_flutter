import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lozalife/core/design_system/app_actions_sheet.dart';
import 'package:lozalife/core/localization/l10n.dart';
import 'package:lozalife/core/theme/app_dimens.dart';
import 'package:lozalife/features/boards/domain/models/board_model.dart';
import 'package:lozalife/features/boards/presentation/actions/board_actions.dart';
import 'package:lozalife/features/tasks/domain/models/task_model.dart';
import 'package:lozalife/features/tasks/presentation/providers/task_providers.dart';

/// A single board entry used both in the permanent side panel and in the
/// mobile drawer. Supports swipe-left actions (pin / delete) and a context
/// menu (rename / pin / delete).
///
/// Also acts as a drop target: dragging a task card onto the tile moves the
/// task to this board (into its first column).
class BoardListTile extends ConsumerWidget {
  final BoardModel board;
  final int taskCount;
  final bool isSelected;
  final VoidCallback onTap;

  const BoardListTile({
    super.key,
    required this.board,
    required this.taskCount,
    required this.isSelected,
    required this.onTap,
  });

  Future<bool?> _onSwipe(BuildContext context, WidgetRef ref) async {
    final _SwipeAction? action = await showAppActionsSheet<_SwipeAction>(
      context,
      actions: [
        AppSheetAction(
          value: _SwipeAction.pin,
          icon: board.isPinned ? Icons.push_pin_outlined : Icons.push_pin,
          label: board.isPinned ? context.l10n.unpinAction : context.l10n.pinAction,
        ),
        AppSheetAction(
          value: _SwipeAction.delete,
          icon: Icons.delete_outline,
          label: context.l10n.deleteAction,
        ),
      ],
    );
    if (!context.mounted) {
      return false;
    }
    switch (action) {
      case _SwipeAction.pin:
        await togglePinBoard(ref, board);
      case _SwipeAction.delete:
        await confirmDeleteBoard(context, ref, board);
      case null:
        break;
    }
    // Never actually dismiss the tile: the list is stream-driven.
    return false;
  }

  void _onMenuAction(BuildContext context, WidgetRef ref, _MenuAction action) {
    switch (action) {
      case _MenuAction.rename:
        showRenameBoardSheet(context, ref, board);
      case _MenuAction.pin:
        togglePinBoard(ref, board);
      case _MenuAction.delete:
        confirmDeleteBoard(context, ref, board);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return DragTarget<TaskModel>(
      onWillAcceptWithDetails: (details) => details.data.boardId != board.id,
      onAcceptWithDetails: (details) =>
          ref.read(taskRepositoryProvider).moveTaskToBoard(
                taskId: details.data.id,
                targetBoardId: board.id,
              ),
      builder: (targetContext, candidateData, rejectedData) => _buildTile(
        targetContext,
        ref,
        colorScheme,
        isDropHovered: candidateData.isNotEmpty,
      ),
    );
  }

  Widget _buildTile(
    BuildContext context,
    WidgetRef ref,
    ColorScheme colorScheme, {
    required bool isDropHovered,
  }) {
    return Dismissible(
      key: ValueKey('board_${board.id}'),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) => _onSwipe(context, ref),
      background: ColoredBox(
        color: colorScheme.errorContainer,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: AppDimens.size16),
            child: Icon(Icons.more_horiz),
          ),
        ),
      ),
      child: ListTile(
        selected: isSelected,
        selectedTileColor: colorScheme.secondaryContainer,
        tileColor: isDropHovered
            ? colorScheme.primaryContainer.withValues(alpha: 0.4)
            : null,
        leading: Icon(
          board.isPinned ? Icons.push_pin : Icons.dashboard_outlined,
          color: Color(board.color),
        ),
        title: Text(
          board.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(context.l10n.boardTaskCount(taskCount)),
        trailing: PopupMenuButton<_MenuAction>(
          onSelected: (action) => _onMenuAction(context, ref, action),
          itemBuilder: (menuContext) => [
            PopupMenuItem(
              value: _MenuAction.rename,
              child: Text(menuContext.l10n.renameAction),
            ),
            PopupMenuItem(
              value: _MenuAction.pin,
              child: Text(
                board.isPinned
                    ? menuContext.l10n.unpinAction
                    : menuContext.l10n.pinAction,
              ),
            ),
            PopupMenuItem(
              value: _MenuAction.delete,
              child: Text(menuContext.l10n.deleteAction),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

enum _SwipeAction { pin, delete }

enum _MenuAction { rename, pin, delete }
