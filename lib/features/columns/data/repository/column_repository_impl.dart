import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'package:lozalife/core/database/app_database.dart';
import 'package:lozalife/features/columns/data/datasource/column_mapper.dart';
import 'package:lozalife/features/columns/domain/models/column_model.dart';
import 'package:lozalife/features/columns/domain/repository/column_repository.dart';

/// Drift-backed implementation of [ColumnRepository].
class ColumnRepositoryImpl implements ColumnRepository {
  final AppDatabase _database;
  final Uuid _uuid;

  ColumnRepositoryImpl(this._database, [this._uuid = const Uuid()]);

  @override
  Stream<List<ColumnModel>> watchColumnsStream(String boardId) =>
      _database.columnDao.watchColumns(boardId).map(
            (rows) => rows.map(mapColumnRowToModel).toList(),
          );

  @override
  Future<void> createColumn(String boardId, String name) async {
    final DateTime now = DateTime.now();
    final int maxOrder = await _database.columnDao.getMaxOrder(boardId);
    await _database.columnDao.insertColumn(
      ColumnTableCompanion.insert(
        id: _uuid.v4(),
        boardId: boardId,
        name: name,
        order: maxOrder + 1,
        createdAt: now,
        updatedAt: now,
      ),
    );
    // TODO(sync): enqueue ColumnCreated operation (Stage 2).
  }

  @override
  Future<void> renameColumn(String columnId, String name) async {
    await _database.columnDao.updateColumn(
      columnId,
      ColumnTableCompanion(
        name: Value(name),
        updatedAt: Value(DateTime.now()),
      ),
    );
    // TODO(sync): enqueue ColumnRenamed operation (Stage 2).
  }

  @override
  Future<void> deleteColumn(
    String columnId, {
    required bool deleteTasks,
  }) async {
    final DateTime now = DateTime.now();
    await _database.transaction(() async {
      if (deleteTasks) {
        await _database.taskDao.updateTasksByColumn(
          columnId,
          TaskTableCompanion(
            deletedAt: Value(now),
            updatedAt: Value(now),
          ),
        );
      }
      await _database.columnDao.updateColumn(
        columnId,
        ColumnTableCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    });
    // TODO(sync): enqueue ColumnDeleted operation (Stage 2).
  }

  @override
  Future<void> deleteColumnMovingTasks(
    String columnId,
    String targetColumnId,
  ) async {
    final DateTime now = DateTime.now();
    await _database.transaction(() async {
      final int maxOrder = await _database.taskDao.getMaxOrder(targetColumnId);
      final List<TaskTableData> tasks =
          await _database.taskDao.getTasksByColumn(columnId);
      for (int index = 0; index < tasks.length; index++) {
        await _database.taskDao.updateTask(
          tasks[index].id,
          TaskTableCompanion(
            columnId: Value(targetColumnId),
            order: Value(maxOrder + 1 + index),
            updatedAt: Value(now),
          ),
        );
      }
      await _database.columnDao.updateColumn(
        columnId,
        ColumnTableCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    });
    // TODO(sync): enqueue TasksMoved + ColumnDeleted operations (Stage 2).
  }
}
