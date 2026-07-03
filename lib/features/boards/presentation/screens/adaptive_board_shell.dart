import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:lozalife/core/design_system/app_async_states.dart';
import 'package:lozalife/core/localization/l10n.dart';
import 'package:lozalife/core/theme/app_dimens.dart';
import 'package:lozalife/features/boards/domain/models/board_model.dart';
import 'package:lozalife/features/boards/presentation/actions/board_actions.dart';
import 'package:lozalife/features/boards/presentation/providers/board_providers.dart';
import 'package:lozalife/features/boards/presentation/widgets/board_content.dart';
import 'package:lozalife/features/boards/presentation/widgets/board_list_panel.dart';

/// The single adaptive screen of the app.
///
/// Wide layouts (>= [AppDimens.wideLayoutBreakpoint]) show a permanent
/// boards panel on the left and the opened board on the right. Narrow
/// layouts hide the panel behind a navigation drawer (burger menu).
///
/// There are deliberately no separate "boards screen" and "board screen":
/// both form factors are served by this shell.
class AdaptiveBoardShell extends ConsumerWidget {
  final String? boardId;

  const AdaptiveBoardShell({super.key, this.boardId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? currentBoardId = boardId;

    // If the opened board was deleted (e.g. from the side panel), leave it.
    if (currentBoardId != null) {
      ref.listen(boardStreamProvider(currentBoardId), (previous, next) {
        final bool wasPresent = previous?.value != null;
        final bool isGone = next is AsyncData<BoardModel?> &&
            (next.value == null || next.value?.deletedAt != null);
        if (wasPresent && isGone) {
          context.go('/');
        }
      });
    }

    final double screenWidth = MediaQuery.sizeOf(context).width;
    final bool isWide = screenWidth >= AppDimens.wideLayoutBreakpoint;

    return isWide
        ? _WideLayout(boardId: currentBoardId)
        : _NarrowLayout(boardId: currentBoardId);
  }
}

/// Permanent side panel + board content.
class _WideLayout extends ConsumerWidget {
  final String? boardId;

  const _WideLayout({required this.boardId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? currentBoardId = boardId;
    return Scaffold(
      appBar: AppBar(
        title: _BoardTitle(boardId: currentBoardId),
        actions: const [_ArchiveAction()],
      ),
      body: Row(
        children: [
          SizedBox(
            width: AppDimens.boardsPanelWidth,
            child: BoardListPanel(selectedBoardId: currentBoardId),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: currentBoardId == null
                ? const _NoBoardPlaceholder()
                : BoardContent(boardId: currentBoardId),
          ),
        ],
      ),
    );
  }
}

/// Drawer-based layout for phones.
class _NarrowLayout extends ConsumerWidget {
  final String? boardId;

  const _NarrowLayout({required this.boardId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? currentBoardId = boardId;
    return Scaffold(
      appBar: AppBar(
        title: _BoardTitle(boardId: currentBoardId),
        actions: const [_ArchiveAction()],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Builder(
            builder: (drawerContext) => BoardListPanel(
              selectedBoardId: currentBoardId,
              onBoardSelected: () => Scaffold.of(drawerContext).closeDrawer(),
            ),
          ),
        ),
      ),
      floatingActionButton: currentBoardId == null
          ? FloatingActionButton(
              tooltip: context.l10n.createBoardTooltip,
              onPressed: () => showCreateBoardSheet(context, ref),
              child: const Icon(Icons.add),
            )
          : null,
      body: currentBoardId == null
          ? const BoardListPanel(selectedBoardId: null)
          : BoardContent(boardId: currentBoardId),
    );
  }
}

/// Board name in the app bar, or the app name when nothing is opened.
class _BoardTitle extends ConsumerWidget {
  final String? boardId;

  const _BoardTitle({required this.boardId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? currentBoardId = boardId;
    if (currentBoardId == null) {
      return Text(context.l10n.appTitle);
    }
    final BoardModel? board =
        ref.watch(boardStreamProvider(currentBoardId)).value;
    return Text(board?.name ?? '');
  }
}

/// Archive entry point: visible per the spec, but disabled until Stage 3.
class _ArchiveAction extends StatelessWidget {
  const _ArchiveAction();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: context.l10n.archiveTooltip,
      icon: const Icon(Icons.archive_outlined),
      onPressed: null,
    );
  }
}

class _NoBoardPlaceholder extends StatelessWidget {
  const _NoBoardPlaceholder();

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      message: context.l10n.selectBoardHint,
    );
  }
}
