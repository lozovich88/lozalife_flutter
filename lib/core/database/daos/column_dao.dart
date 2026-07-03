import 'package:drift/drift.dart';

import 'package:lozalife/core/database/app_database.dart';
import 'package:lozalife/core/database/tables.dart';

part 'column_dao.g.dart';

@DriftAccessor(tables: [ColumnTable])
class ColumnDao extends DatabaseAccessor<AppDatabase> with _$ColumnDaoMixin {
  ColumnDao(super.attachedDatabase);

  /// Streams alive columns of a board ordered by manual order.
  Stream<List<ColumnTableData>> watchColumns(String boardId) {
    final SimpleSelectStatement<$ColumnTableTable, ColumnTableData> query =
        select(columnTable)
          ..where((tbl) => tbl.boardId.equals(boardId) & tbl.deletedAt.isNull())
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.order)]);
    return query.watch();
  }

  /// First alive column of a board (by manual order), or null when the
  /// board has no columns.
  Future<ColumnTableData?> getFirstColumn(String boardId) {
    final SimpleSelectStatement<$ColumnTableTable, ColumnTableData> query =
        select(columnTable)
          ..where((tbl) => tbl.boardId.equals(boardId) & tbl.deletedAt.isNull())
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.order)])
          ..limit(1);
    return query.getSingleOrNull();
  }

  Future<int> getMaxOrder(String boardId) async {
    final Expression<int> maxExpression = columnTable.order.max();
    final JoinedSelectStatement<HasResultSet, dynamic> query =
        selectOnly(columnTable)
          ..addColumns([maxExpression])
          ..where(columnTable.boardId.equals(boardId) &
              columnTable.deletedAt.isNull());
    final TypedResult row = await query.getSingle();
    return row.read(maxExpression) ?? -1;
  }

  Future<void> insertColumn(ColumnTableCompanion companion) =>
      into(columnTable).insert(companion);

  Future<void> updateColumn(String columnId, ColumnTableCompanion companion) =>
      (update(columnTable)..where((tbl) => tbl.id.equals(columnId)))
          .write(companion);
}
