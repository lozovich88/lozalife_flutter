import 'package:drift/drift.dart';

import 'package:lozalife/core/database/app_database.dart';
import 'package:lozalife/core/database/tables.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [TaskTable])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(super.attachedDatabase);

  /// Streams all alive tasks of a board ordered inside their columns.
  ///
  /// When [searchQuery] is not empty, filters by title using SQL `LIKE`
  /// (case-insensitive, partial match). Filtering happens in SQLite, not in
  /// memory.
  Stream<List<TaskTableData>> watchTasksByBoard(
    String boardId, {
    String searchQuery = '',
  }) {
    final SimpleSelectStatement<$TaskTableTable, TaskTableData> query =
        select(taskTable)
          ..where((tbl) =>
              tbl.boardId.equals(boardId) &
              tbl.deletedAt.isNull() &
              tbl.isArchived.equals(false))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.order)]);
    if (searchQuery.isNotEmpty) {
      // SQLite LIKE is case-insensitive by default, which satisfies the
      // search requirements of the MVP.
      final String pattern = '%$searchQuery%';
      query.where((tbl) => tbl.title.like(pattern));
    }
    return query.watch();
  }

  Future<TaskTableData?> getTask(String taskId) {
    final SimpleSelectStatement<$TaskTableTable, TaskTableData> query =
        select(taskTable)..where((tbl) => tbl.id.equals(taskId));
    return query.getSingleOrNull();
  }

  Stream<TaskTableData?> watchTask(String taskId) {
    final SimpleSelectStatement<$TaskTableTable, TaskTableData> query =
        select(taskTable)..where((tbl) => tbl.id.equals(taskId));
    return query.watchSingleOrNull();
  }

  Future<int> getMaxOrder(String columnId) async {
    final Expression<int> maxExpression = taskTable.order.max();
    final JoinedSelectStatement<HasResultSet, dynamic> query =
        selectOnly(taskTable)
          ..addColumns([maxExpression])
          ..where(taskTable.columnId.equals(columnId) &
              taskTable.deletedAt.isNull());
    final TypedResult row = await query.getSingle();
    return row.read(maxExpression) ?? -1;
  }

  Future<List<TaskTableData>> getTasksByColumn(String columnId) {
    final SimpleSelectStatement<$TaskTableTable, TaskTableData> query =
        select(taskTable)
          ..where((tbl) =>
              tbl.columnId.equals(columnId) & tbl.deletedAt.isNull())
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.order)]);
    return query.get();
  }

  Future<void> insertTask(TaskTableCompanion companion) =>
      into(taskTable).insert(companion);

  Future<void> updateTask(String taskId, TaskTableCompanion companion) =>
      (update(taskTable)..where((tbl) => tbl.id.equals(taskId)))
          .write(companion);

  Future<void> updateTasksByColumn(
    String columnId,
    TaskTableCompanion companion,
  ) =>
      (update(taskTable)
            ..where((tbl) =>
                tbl.columnId.equals(columnId) & tbl.deletedAt.isNull()))
          .write(companion);
}
