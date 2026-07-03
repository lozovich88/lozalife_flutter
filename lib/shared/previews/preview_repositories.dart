import 'package:lozalife/features/boards/domain/models/board_model.dart';
import 'package:lozalife/features/boards/domain/repository/board_repository.dart';
import 'package:lozalife/features/columns/domain/models/column_model.dart';
import 'package:lozalife/features/columns/domain/repository/column_repository.dart';
import 'package:lozalife/features/tasks/domain/models/task_model.dart';
import 'package:lozalife/features/tasks/domain/repository/task_repository.dart';
import 'package:lozalife/shared/previews/preview_data.dart';

/// In-memory repositories used by widget previews instead of the real
/// Drift-backed implementations. Reads serve static demo data, mutations
/// are no-ops.

class PreviewBoardRepository implements BoardRepository {
  @override
  Stream<List<BoardModel>> watchBoardsStream() => Stream.value(previewBoards);

  @override
  Stream<Map<String, int>> watchTaskCountsStream() =>
      Stream.value(previewTaskCounts);

  @override
  Stream<BoardModel?> watchBoardStream(String boardId) => Stream.value(
        previewBoards
            .where((board) => board.id == boardId)
            .firstOrNull,
      );

  @override
  Future<String> createBoard(String name) async => previewBoards.first.id;

  @override
  Future<void> renameBoard(String boardId, String name) async {}

  @override
  Future<void> setPinned(String boardId, bool isPinned) async {}

  @override
  Future<void> deleteBoard(String boardId) async {}
}

class PreviewColumnRepository implements ColumnRepository {
  @override
  Stream<List<ColumnModel>> watchColumnsStream(String boardId) => Stream.value(
        previewColumns
            .where((column) => column.boardId == boardId)
            .toList(),
      );

  @override
  Future<void> createColumn(String boardId, String name) async {}

  @override
  Future<void> renameColumn(String columnId, String name) async {}

  @override
  Future<void> deleteColumn(
    String columnId, {
    required bool deleteTasks,
  }) async {}

  @override
  Future<void> deleteColumnMovingTasks(
    String columnId,
    String targetColumnId,
  ) async {}
}

class PreviewTaskRepository implements TaskRepository {
  @override
  Stream<List<TaskModel>> watchTasksByBoardStream(
    String boardId, {
    String searchQuery = '',
  }) {
    final String query = searchQuery.toLowerCase();
    return Stream.value(
      previewTasks
          .where((task) => task.boardId == boardId)
          .where((task) => task.title.toLowerCase().contains(query))
          .toList(),
    );
  }

  @override
  Stream<TaskModel?> watchTaskStream(String taskId) => Stream.value(
        previewTasks
            .where((task) => task.id == taskId)
            .firstOrNull,
      );

  @override
  Future<void> createTask({
    required String boardId,
    required String columnId,
    required String title,
    String? description,
    DateTime? deadline,
  }) async {}

  @override
  Future<void> updateTask({
    required String taskId,
    required String title,
    String? description,
    DateTime? deadline,
  }) async {}

  @override
  Future<void> deleteTask(String taskId) async {}

  @override
  Future<void> moveTask({
    required String taskId,
    required String targetColumnId,
    required int targetIndex,
  }) async {}

  @override
  Future<void> moveTaskToBoard({
    required String taskId,
    required String targetBoardId,
  }) async {}
}
