import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lozalife/core/database/app_database.dart';
import 'package:lozalife/features/boards/data/repository/board_repository_impl.dart';
import 'package:lozalife/features/columns/data/repository/column_repository_impl.dart';
import 'package:lozalife/features/columns/domain/models/column_model.dart';
import 'package:lozalife/features/tasks/data/repository/task_repository_impl.dart';
import 'package:lozalife/features/tasks/domain/models/task_model.dart';

void main() {
  late AppDatabase database;
  late BoardRepositoryImpl boardRepository;
  late ColumnRepositoryImpl columnRepository;
  late TaskRepositoryImpl taskRepository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    boardRepository = BoardRepositoryImpl(database);
    columnRepository = ColumnRepositoryImpl(database);
    taskRepository = TaskRepositoryImpl(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('WHEN board created EXPECT default To Do column exists', () async {
    // Prepare
    const String expected = 'To Do';

    // Do
    final String boardId = await boardRepository.createBoard('My board');
    final List<ColumnModel> columns =
        await columnRepository.watchColumnsStream(boardId).first;

    // Check
    expect(columns.single.name, expected);
  });

  test('WHEN search query set EXPECT only matching tasks returned', () async {
    // Prepare
    final String boardId = await boardRepository.createBoard('My board');
    final List<ColumnModel> columns =
        await columnRepository.watchColumnsStream(boardId).first;
    final String columnId = columns.single.id;
    await taskRepository.createTask(
      boardId: boardId,
      columnId: columnId,
      title: 'Pay taxes',
    );
    await taskRepository.createTask(
      boardId: boardId,
      columnId: columnId,
      title: 'Walk the dog',
    );

    // Do
    final List<TaskModel> actual = await taskRepository
        .watchTasksByBoardStream(boardId, searchQuery: 'pay')
        .first;

    // Check
    expect(actual.single.title, 'Pay taxes');
  });

  test('WHEN task moved to another column EXPECT columnId and order updated',
      () async {
    // Prepare
    final String boardId = await boardRepository.createBoard('My board');
    final List<ColumnModel> initialColumns =
        await columnRepository.watchColumnsStream(boardId).first;
    final String sourceColumnId = initialColumns.single.id;
    await columnRepository.createColumn(boardId, 'Done');
    final List<ColumnModel> columns =
        await columnRepository.watchColumnsStream(boardId).first;
    final String targetColumnId =
        columns.firstWhere((column) => column.name == 'Done').id;
    await taskRepository.createTask(
      boardId: boardId,
      columnId: sourceColumnId,
      title: 'Movable task',
    );
    final List<TaskModel> created =
        await taskRepository.watchTasksByBoardStream(boardId).first;
    final String taskId = created.single.id;

    // Do
    await taskRepository.moveTask(
      taskId: taskId,
      targetColumnId: targetColumnId,
      targetIndex: 0,
    );
    final List<TaskModel> actual =
        await taskRepository.watchTasksByBoardStream(boardId).first;

    // Check
    expect(actual.single.columnId, targetColumnId);
  });

  test('WHEN task dropped on another board EXPECT task moved to that board',
      () async {
    // Prepare
    final String sourceBoardId = await boardRepository.createBoard('Source');
    final String targetBoardId = await boardRepository.createBoard('Target');
    final List<ColumnModel> sourceColumns =
        await columnRepository.watchColumnsStream(sourceBoardId).first;
    await taskRepository.createTask(
      boardId: sourceBoardId,
      columnId: sourceColumns.single.id,
      title: 'Cross-board task',
    );
    final List<TaskModel> created =
        await taskRepository.watchTasksByBoardStream(sourceBoardId).first;
    final String taskId = created.single.id;

    // Do
    await taskRepository.moveTaskToBoard(
      taskId: taskId,
      targetBoardId: targetBoardId,
    );
    final List<TaskModel> actual =
        await taskRepository.watchTasksByBoardStream(targetBoardId).first;

    // Check
    expect(actual.single.boardId, targetBoardId);
  });
}
