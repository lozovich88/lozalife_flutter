import 'package:lozalife/features/tasks/domain/models/task_model.dart';

/// Tasks contract for the presentation layer.
abstract interface class TaskRepository {
  /// All alive tasks of a board, ordered inside their columns.
  ///
  /// A non-empty [searchQuery] filters tasks by title with SQL LIKE
  /// (case-insensitive, partial match).
  Stream<List<TaskModel>> watchTasksByBoardStream(
    String boardId, {
    String searchQuery,
  });

  Stream<TaskModel?> watchTaskStream(String taskId);

  Future<void> createTask({
    required String boardId,
    required String columnId,
    required String title,
    String? description,
    DateTime? deadline,
  });

  Future<void> updateTask({
    required String taskId,
    required String title,
    String? description,
    DateTime? deadline,
  });

  Future<void> deleteTask(String taskId);

  /// Persists the result of a drag&drop: the task gets a new column and a
  /// new position inside it. Reorders affected neighbours as well.
  Future<void> moveTask({
    required String taskId,
    required String targetColumnId,
    required int targetIndex,
  });

  /// Moves the task to another board: it lands at the end of the first
  /// column of [targetBoardId]. When the target board has no columns, a
  /// default one is created. Dropping onto the task's own board is a no-op.
  Future<void> moveTaskToBoard({
    required String taskId,
    required String targetBoardId,
  });
}
