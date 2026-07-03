import 'package:lozalife/features/boards/domain/models/board_model.dart';
import 'package:lozalife/features/columns/domain/models/column_model.dart';
import 'package:lozalife/features/tasks/domain/models/task_model.dart';

/// Static demo data used by widget previews.

final DateTime _createdAt = DateTime(2026, 7, 1);

final List<BoardModel> previewBoards = [
  BoardModel(
    id: 'board-1',
    name: 'Product Launch',
    color: 0xFF3F51B5,
    isPinned: true,
    order: 0,
    createdAt: _createdAt,
    updatedAt: _createdAt,
  ),
  BoardModel(
    id: 'board-2',
    name: 'Personal',
    color: 0xFF4CAF50,
    isPinned: false,
    order: 1,
    createdAt: _createdAt,
    updatedAt: _createdAt,
  ),
  BoardModel(
    id: 'board-3',
    name: 'Groceries and household chores',
    color: 0xFFFF9800,
    isPinned: false,
    order: 2,
    createdAt: _createdAt,
    updatedAt: _createdAt,
  ),
];

final List<ColumnModel> previewColumns = [
  ColumnModel(
    id: 'column-1',
    boardId: 'board-1',
    name: 'To Do',
    order: 0,
    createdAt: _createdAt,
    updatedAt: _createdAt,
  ),
  ColumnModel(
    id: 'column-2',
    boardId: 'board-1',
    name: 'In Progress',
    order: 1,
    createdAt: _createdAt,
    updatedAt: _createdAt,
  ),
  ColumnModel(
    id: 'column-3',
    boardId: 'board-1',
    name: 'Done',
    order: 2,
    createdAt: _createdAt,
    updatedAt: _createdAt,
  ),
];

final List<TaskModel> previewTasks = [
  TaskModel(
    id: 'task-1',
    boardId: 'board-1',
    columnId: 'column-1',
    title: 'Prepare launch checklist',
    description: 'Go through the release plan, verify store listings, '
        'screenshots and the press kit before the announcement.',
    deadline: DateTime(2026, 7, 20),
    order: 0,
    isArchived: false,
    createdAt: _createdAt,
    updatedAt: _createdAt,
  ),
  TaskModel(
    id: 'task-2',
    boardId: 'board-1',
    columnId: 'column-1',
    title: 'Write release notes',
    order: 1,
    isArchived: false,
    createdAt: _createdAt,
    updatedAt: _createdAt,
  ),
  TaskModel(
    id: 'task-3',
    boardId: 'board-1',
    columnId: 'column-2',
    title: 'Fix overdue payment reminder',
    description: 'The reminder fires twice on Mondays.',
    deadline: DateTime(2026, 6, 15),
    order: 0,
    isArchived: false,
    createdAt: _createdAt,
    updatedAt: _createdAt,
  ),
  TaskModel(
    id: 'task-4',
    boardId: 'board-1',
    columnId: 'column-3',
    title: 'Set up CI pipeline',
    order: 0,
    isArchived: false,
    createdAt: _createdAt,
    updatedAt: _createdAt,
  ),
];

/// Task counts per board id, matching [previewTasks].
final Map<String, int> previewTaskCounts = {
  'board-1': 4,
  'board-2': 2,
  'board-3': 0,
};
