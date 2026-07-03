import 'package:lozalife/features/columns/domain/models/column_model.dart';

/// Columns contract for the presentation layer.
abstract interface class ColumnRepository {
  Stream<List<ColumnModel>> watchColumnsStream(String boardId);

  Future<void> createColumn(String boardId, String name);

  Future<void> renameColumn(String columnId, String name);

  /// Deletes an empty column, or deletes it together with its tasks.
  Future<void> deleteColumn(String columnId, {required bool deleteTasks});

  /// Moves all tasks of [columnId] to [targetColumnId], then deletes the
  /// column.
  Future<void> deleteColumnMovingTasks(String columnId, String targetColumnId);
}
