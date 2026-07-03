import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:lozalife/core/design_system/app_dialogs.dart';
import 'package:lozalife/core/design_system/app_name_sheet.dart';
import 'package:lozalife/core/localization/l10n.dart';
import 'package:lozalife/features/boards/domain/models/board_model.dart';
import 'package:lozalife/features/boards/presentation/providers/board_providers.dart';

/// Opens the bottom sheet for creating a board. On success creates the board
/// (with the default "To Do" column) and navigates to it.
Future<void> showCreateBoardSheet(BuildContext context, WidgetRef ref) async {
  final String? name = await showAppNameSheet(
    context,
    title: context.l10n.newBoardTitle,
    confirmLabel: context.l10n.createAction,
  );
  if (name == null || name.isEmpty) {
    return;
  }
  final String boardId =
      await ref.read(boardRepositoryProvider).createBoard(name);
  if (context.mounted) {
    context.go('/board/$boardId');
  }
}

/// Opens the rename sheet pre-filled with the current board name.
Future<void> showRenameBoardSheet(
  BuildContext context,
  WidgetRef ref,
  BoardModel board,
) async {
  final String? name = await showAppNameSheet(
    context,
    title: context.l10n.renameBoardTitle,
    confirmLabel: context.l10n.saveAction,
    initialValue: board.name,
  );
  if (name == null || name.isEmpty) {
    return;
  }
  await ref.read(boardRepositoryProvider).renameBoard(board.id, name);
}

/// Asks for confirmation and soft-deletes the board.
Future<void> confirmDeleteBoard(
  BuildContext context,
  WidgetRef ref,
  BoardModel board,
) async {
  final bool confirmed = await showAppConfirmDialog(
    context,
    title: context.l10n.deleteBoardQuestion(board.name),
    message: context.l10n.deleteBoardWarning,
    confirmLabel: context.l10n.deleteAction,
  );
  if (!confirmed) {
    return;
  }
  await ref.read(boardRepositoryProvider).deleteBoard(board.id);
  // The board screen reacts to the deleted board through its stream and
  // redirects home by itself; no navigation is required here.
}

Future<void> togglePinBoard(WidgetRef ref, BoardModel board) =>
    ref.read(boardRepositoryProvider).setPinned(board.id, !board.isPinned);
