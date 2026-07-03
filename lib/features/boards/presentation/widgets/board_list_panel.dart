import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:lozalife/core/design_system/app_async_states.dart';
import 'package:lozalife/core/localization/l10n.dart';
import 'package:lozalife/core/theme/app_dimens.dart';
import 'package:lozalife/features/boards/domain/models/board_model.dart';
import 'package:lozalife/features/boards/presentation/actions/board_actions.dart';
import 'package:lozalife/features/boards/presentation/providers/board_providers.dart';
import 'package:lozalife/features/boards/presentation/widgets/board_list_tile.dart';

/// The boards list, reused by the permanent side panel (wide screens) and
/// by the navigation drawer (narrow screens).
class BoardListPanel extends ConsumerWidget {
  final String? selectedBoardId;

  /// Called after a board is picked; the drawer uses this to close itself.
  final VoidCallback? onBoardSelected;

  const BoardListPanel({
    super.key,
    required this.selectedBoardId,
    this.onBoardSelected,
  });

  void _openBoard(BuildContext context, String boardId) {
    context.go('/board/$boardId');
    onBoardSelected?.call();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<BoardModel>> boards =
        ref.watch(boardsStreamProvider);
    final Map<String, int> taskCounts =
        ref.watch(boardTaskCountsProvider).value ?? const {};

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.size16,
            vertical: AppDimens.size8,
          ),
          child: Row(
            children: [
              Text(
                context.l10n.boardsTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              IconButton(
                tooltip: context.l10n.createBoardTooltip,
                icon: const Icon(Icons.add),
                onPressed: () => showCreateBoardSheet(context, ref),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: boards.when(
            loading: () => const AppLoadingState(),
            error: (error, stackTrace) => AppErrorState(
              message: context.l10n.failedToLoadBoards('$error'),
            ),
            data: (items) {
              if (items.isEmpty) {
                return AppEmptyState(
                  message: context.l10n.noBoardsYet,
                );
              }
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (listContext, index) {
                  final BoardModel board = items[index];
                  return BoardListTile(
                    board: board,
                    taskCount: taskCounts[board.id] ?? 0,
                    isSelected: board.id == selectedBoardId,
                    onTap: () => _openBoard(listContext, board.id),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
