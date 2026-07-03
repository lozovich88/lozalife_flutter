import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lozalife/features/columns/domain/models/column_model.dart';
import 'package:lozalife/features/columns/presentation/providers/column_providers.dart';
import 'package:lozalife/features/tasks/domain/models/task_model.dart';
import 'package:lozalife/features/tasks/presentation/providers/task_providers.dart';
import 'package:lozalife/features/tasks/presentation/state/board_search_state.dart';

/// Columns to render on the board.
///
/// Without an active search this simply mirrors the columns stream. During a
/// search, columns that have no matching tasks are hidden.
final visibleColumnsProvider =
    Provider.family<AsyncValue<List<ColumnModel>>, String>(
  (ref, boardId) {
    final AsyncValue<List<ColumnModel>> columns =
        ref.watch(columnsStreamProvider(boardId));
    final String searchQuery = ref.watch(boardSearchQueryProvider);
    if (searchQuery.isEmpty) {
      return columns;
    }
    final List<TaskModel> matchingTasks =
        ref.watch(boardTasksProvider(boardId)).value ?? const <TaskModel>[];
    final Set<String> columnIdsWithMatches =
        matchingTasks.map((task) => task.columnId).toSet();
    return columns.whenData(
      (items) => items
          .where((column) => columnIdsWithMatches.contains(column.id))
          .toList(),
    );
  },
);
