import 'package:flutter/material.dart';

import 'package:lozalife/features/boards/presentation/screens/adaptive_board_shell.dart';
import 'package:lozalife/features/boards/presentation/widgets/board_content.dart';
import 'package:lozalife/features/boards/presentation/widgets/board_list_panel.dart';
import 'package:lozalife/features/boards/presentation/widgets/board_list_tile.dart';
import 'package:lozalife/features/boards/presentation/widgets/board_search_bar.dart';
import 'package:lozalife/shared/previews/app_preview.dart';
import 'package:lozalife/shared/previews/preview_data.dart';

/// Widget previews for the boards feature.
///
/// Run with `flutter widget-preview start`.

const String _group = 'Boards';

@AppPreview(name: 'Board list tile', group: _group, size: Size(300, 90))
Widget boardListTilePreview() => BoardListTile(
      board: previewBoards.first,
      taskCount: previewTaskCounts[previewBoards.first.id] ?? 0,
      isSelected: false,
      onTap: () {},
    );

@AppPreview(
  name: 'Board list tile — selected & pinned',
  group: _group,
  size: Size(300, 90),
)
Widget selectedBoardListTilePreview() => BoardListTile(
      board: previewBoards.first,
      taskCount: previewTaskCounts[previewBoards.first.id] ?? 0,
      isSelected: true,
      onTap: () {},
    );

@AppPreview(name: 'Board list panel', group: _group, size: Size(300, 480))
Widget boardListPanelPreview() => BoardListPanel(
      selectedBoardId: previewBoards.first.id,
    );

@AppPreview(name: 'Search bar', group: _group, size: Size(360, 90))
Widget boardSearchBarPreview() => const BoardSearchBar();

@AppPreview(
  name: 'Board content',
  group: _group,
  size: Size(1000, 640),
)
Widget boardContentPreview() => BoardContent(boardId: previewBoards.first.id);

@AppPreview(
  name: 'Adaptive shell — wide (permanent panel)',
  group: 'Screens',
  size: Size(1280, 800),
)
Widget wideShellPreview() => MediaQuery(
      // Pin the window size so the shell reliably picks the wide layout.
      data: const MediaQueryData(size: Size(1280, 800)),
      child: AdaptiveBoardShell(boardId: previewBoards.first.id),
    );

@AppPreview(
  name: 'Adaptive shell — narrow (drawer)',
  group: 'Screens',
  size: Size(400, 800),
)
Widget narrowShellPreview() => MediaQuery(
      data: const MediaQueryData(size: Size(400, 800)),
      child: AdaptiveBoardShell(boardId: previewBoards.first.id),
    );

@AppPreview(
  name: 'Adaptive shell — narrow, boards list',
  group: 'Screens',
  size: Size(400, 800),
)
Widget narrowBoardsListShellPreview() => const MediaQuery(
      data: MediaQueryData(size: Size(400, 800)),
      child: AdaptiveBoardShell(),
    );
