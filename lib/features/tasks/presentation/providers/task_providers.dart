import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lozalife/core/database/database_provider.dart';
import 'package:lozalife/features/tasks/data/repository/task_repository_impl.dart';
import 'package:lozalife/features/tasks/domain/models/task_model.dart';
import 'package:lozalife/features/tasks/domain/repository/task_repository.dart';
import 'package:lozalife/features/tasks/presentation/state/board_search_state.dart';

final Provider<TaskRepository> taskRepositoryProvider =
    Provider<TaskRepository>(
  (ref) => TaskRepositoryImpl(ref.watch(appDatabaseProvider)),
);

/// All alive tasks of a board, filtered by the debounced search query.
///
/// The SQL LIKE filter runs inside SQLite; this stream re-emits both when
/// data changes and when the search query changes.
final boardTasksProvider = StreamProvider.family<List<TaskModel>, String>(
  (ref, boardId) {
    final String searchQuery = ref.watch(boardSearchQueryProvider);
    return ref
        .watch(taskRepositoryProvider)
        .watchTasksByBoardStream(boardId, searchQuery: searchQuery);
  },
);

/// Tasks of a single column, derived from [boardTasksProvider].
///
/// Column widgets watch this provider instead of the whole board list, so a
/// change in one column does not rebuild the entire board.
final columnTasksProvider =
    Provider.family<List<TaskModel>, ({String boardId, String columnId})>(
  (ref, args) {
    final List<TaskModel> boardTasks =
        ref.watch(boardTasksProvider(args.boardId)).value ??
            const <TaskModel>[];
    return boardTasks
        .where((task) => task.columnId == args.columnId)
        .toList();
  },
);

/// Single task by id (null when deleted or missing).
final taskStreamProvider = StreamProvider.family<TaskModel?, String>(
  (ref, taskId) => ref.watch(taskRepositoryProvider).watchTaskStream(taskId),
);
