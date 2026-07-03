import 'package:drift/drift.dart';

import 'package:lozalife/core/database/app_database.dart';
import 'package:lozalife/core/database/tables.dart';

part 'board_dao.g.dart';

@DriftAccessor(tables: [BoardTable, TaskTable])
class BoardDao extends DatabaseAccessor<AppDatabase> with _$BoardDaoMixin {
  BoardDao(super.attachedDatabase);

  /// Streams all alive boards: pinned first, then by manual order.
  Stream<List<BoardTableData>> watchBoards() {
    final SimpleSelectStatement<$BoardTableTable, BoardTableData> query =
        select(boardTable)
          ..where((tbl) => tbl.deletedAt.isNull())
          ..orderBy([
            (tbl) => OrderingTerm.desc(tbl.isPinned),
            (tbl) => OrderingTerm.asc(tbl.order),
            (tbl) => OrderingTerm.asc(tbl.createdAt),
          ]);
    return query.watch();
  }

  /// Streams the number of alive tasks per board (for board cards).
  Stream<Map<String, int>> watchTaskCounts() {
    final Expression<int> countExpression = taskTable.id.count();
    final JoinedSelectStatement<HasResultSet, dynamic> query =
        selectOnly(taskTable)
          ..addColumns([taskTable.boardId, countExpression])
          ..where(taskTable.deletedAt.isNull() &
              taskTable.isArchived.equals(false))
          ..groupBy([taskTable.boardId]);
    return query.watch().map((rows) {
      return {
        for (final TypedResult row in rows)
          row.read(taskTable.boardId)!: row.read(countExpression) ?? 0,
      };
    });
  }

  Stream<BoardTableData?> watchBoard(String boardId) {
    final SimpleSelectStatement<$BoardTableTable, BoardTableData> query =
        select(boardTable)..where((tbl) => tbl.id.equals(boardId));
    return query.watchSingleOrNull();
  }

  Future<BoardTableData?> getBoard(String boardId) {
    final SimpleSelectStatement<$BoardTableTable, BoardTableData> query =
        select(boardTable)..where((tbl) => tbl.id.equals(boardId));
    return query.getSingleOrNull();
  }

  Future<int> getMaxOrder() async {
    final Expression<int> maxExpression = boardTable.order.max();
    final JoinedSelectStatement<HasResultSet, dynamic> query =
        selectOnly(boardTable)
          ..addColumns([maxExpression])
          ..where(boardTable.deletedAt.isNull());
    final TypedResult row = await query.getSingle();
    return row.read(maxExpression) ?? -1;
  }

  Future<void> insertBoard(BoardTableCompanion companion) =>
      into(boardTable).insert(companion);

  Future<void> updateBoard(String boardId, BoardTableCompanion companion) =>
      (update(boardTable)..where((tbl) => tbl.id.equals(boardId)))
          .write(companion);
}
