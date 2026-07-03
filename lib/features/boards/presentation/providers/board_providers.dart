import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lozalife/core/database/database_provider.dart';
import 'package:lozalife/features/boards/data/repository/board_repository_impl.dart';
import 'package:lozalife/features/boards/domain/models/board_model.dart';
import 'package:lozalife/features/boards/domain/repository/board_repository.dart';

final Provider<BoardRepository> boardRepositoryProvider =
    Provider<BoardRepository>(
  (ref) => BoardRepositoryImpl(ref.watch(appDatabaseProvider)),
);

/// Alive boards: pinned first, then by manual order.
final StreamProvider<List<BoardModel>> boardsStreamProvider =
    StreamProvider<List<BoardModel>>(
  (ref) => ref.watch(boardRepositoryProvider).watchBoardsStream(),
);

/// Alive task count per board id, used on board cards.
final StreamProvider<Map<String, int>> boardTaskCountsProvider =
    StreamProvider<Map<String, int>>(
  (ref) => ref.watch(boardRepositoryProvider).watchTaskCountsStream(),
);

/// Single board by id (null when deleted or missing).
final boardStreamProvider = StreamProvider.family<BoardModel?, String>(
  (ref, boardId) =>
      ref.watch(boardRepositoryProvider).watchBoardStream(boardId),
);
