import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'package:lozalife/core/database/app_database.dart';
import 'package:lozalife/features/tasks/data/datasource/task_mapper.dart';
import 'package:lozalife/features/tasks/domain/models/task_model.dart';
import 'package:lozalife/features/tasks/domain/repository/task_repository.dart';

/// Drift-backed implementation of [TaskRepository].
class TaskRepositoryImpl implements TaskRepository {
  static const String _defaultColumnName = 'To Do';

  final AppDatabase _database;
  final Uuid _uuid;

  TaskRepositoryImpl(this._database, [this._uuid = const Uuid()]);

  @override
  Stream<List<TaskModel>> watchTasksByBoardStream(
    String boardId, {
    String searchQuery = '',
  }) =>
      _database.taskDao
          .watchTasksByBoard(boardId, searchQuery: searchQuery)
          .map((rows) => rows.map(mapTaskRowToModel).toList());

  @override
  Stream<TaskModel?> watchTaskStream(String taskId) =>
      _database.taskDao.watchTask(taskId).map(
            (row) => row == null ? null : mapTaskRowToModel(row),
          );

  @override
  Future<void> createTask({
    required String boardId,
    required String columnId,
    required String title,
    String? description,
    DateTime? deadline,
  }) async {
    final DateTime now = DateTime.now();
    final int maxOrder = await _database.taskDao.getMaxOrder(columnId);
    await _database.taskDao.insertTask(
      TaskTableCompanion.insert(
        id: _uuid.v4(),
        boardId: boardId,
        columnId: columnId,
        title: title,
        description: Value(description),
        deadline: Value(deadline),
        order: maxOrder + 1,
        createdAt: now,
        updatedAt: now,
      ),
    );
    // TODO(sync): enqueue TaskCreated operation (Stage 2).
  }

  @override
  Future<void> updateTask({
    required String taskId,
    required String title,
    String? description,
    DateTime? deadline,
  }) async {
    await _database.taskDao.updateTask(
      taskId,
      TaskTableCompanion(
        title: Value(title),
        description: Value(description),
        deadline: Value(deadline),
        updatedAt: Value(DateTime.now()),
      ),
    );
    // TODO(sync): enqueue TaskUpdated operation (Stage 2).
  }

  @override
  Future<void> deleteTask(String taskId) async {
    final DateTime now = DateTime.now();
    await _database.taskDao.updateTask(
      taskId,
      TaskTableCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
    // TODO(sync): enqueue TaskDeleted operation (Stage 2).
  }

  @override
  Future<void> moveTask({
    required String taskId,
    required String targetColumnId,
    required int targetIndex,
  }) async {
    final DateTime now = DateTime.now();
    await _database.transaction(() async {
      final List<TaskTableData> targetTasks =
          await _database.taskDao.getTasksByColumn(targetColumnId);
      final List<TaskTableData> reordered =
          targetTasks.where((task) => task.id != taskId).toList();
      final int insertIndex = targetIndex.clamp(0, reordered.length);

      // Rewrite orders of the target column with a gap for the moved task.
      for (int index = 0; index < reordered.length; index++) {
        final int newOrder = index < insertIndex ? index : index + 1;
        if (reordered[index].order != newOrder) {
          await _database.taskDao.updateTask(
            reordered[index].id,
            TaskTableCompanion(
              order: Value(newOrder),
              updatedAt: Value(now),
            ),
          );
        }
      }
      await _database.taskDao.updateTask(
        taskId,
        TaskTableCompanion(
          columnId: Value(targetColumnId),
          order: Value(insertIndex),
          updatedAt: Value(now),
        ),
      );
    });
    // TODO(sync): enqueue TaskMoved operation (Stage 2).
  }

  @override
  Future<void> moveTaskToBoard({
    required String taskId,
    required String targetBoardId,
  }) async {
    final DateTime now = DateTime.now();
    await _database.transaction(() async {
      final TaskTableData? task = await _database.taskDao.getTask(taskId);
      if (task == null || task.boardId == targetBoardId) {
        return;
      }
      final String targetColumnId =
          await _getOrCreateFirstColumn(targetBoardId, now);
      final int maxOrder = await _database.taskDao.getMaxOrder(targetColumnId);
      await _database.taskDao.updateTask(
        taskId,
        TaskTableCompanion(
          boardId: Value(targetBoardId),
          columnId: Value(targetColumnId),
          order: Value(maxOrder + 1),
          updatedAt: Value(now),
        ),
      );
    });
    // TODO(sync): enqueue TaskMoved operation (Stage 2).
  }

  /// The app keeps at least one column per board, but the last column can
  /// still be deleted manually — recreate the default one in that case.
  Future<String> _getOrCreateFirstColumn(String boardId, DateTime now) async {
    final ColumnTableData? firstColumn =
        await _database.columnDao.getFirstColumn(boardId);
    if (firstColumn != null) {
      return firstColumn.id;
    }
    final String columnId = _uuid.v4();
    await _database.columnDao.insertColumn(
      ColumnTableCompanion.insert(
        id: columnId,
        boardId: boardId,
        name: _defaultColumnName,
        order: 0,
        createdAt: now,
        updatedAt: now,
      ),
    );
    return columnId;
  }
}
