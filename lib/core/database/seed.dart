import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'package:lozalife/core/database/app_database.dart';

/// Populates the database with demo data on the very first launch so that
/// the app is not empty when opened for the first time.
Future<void> seedDatabase(AppDatabase database) async {
  const Uuid uuid = Uuid();
  final DateTime now = DateTime.now();

  final String boardId = uuid.v4();
  final String todoColumnId = uuid.v4();
  final String inProgressColumnId = uuid.v4();
  final String doneColumnId = uuid.v4();

  await database.batch((batch) {
    batch.insert(
      database.boardTable,
      BoardTableCompanion.insert(
        id: boardId,
        name: 'Welcome Board',
        color: 0xFF3F51B5,
        order: 0,
        createdAt: now,
        updatedAt: now,
      ),
    );

    batch.insertAll(database.columnTable, [
      ColumnTableCompanion.insert(
        id: todoColumnId,
        boardId: boardId,
        name: 'To Do',
        order: 0,
        createdAt: now,
        updatedAt: now,
      ),
      ColumnTableCompanion.insert(
        id: inProgressColumnId,
        boardId: boardId,
        name: 'In Progress',
        order: 1,
        createdAt: now,
        updatedAt: now,
      ),
      ColumnTableCompanion.insert(
        id: doneColumnId,
        boardId: boardId,
        name: 'Done',
        order: 2,
        createdAt: now,
        updatedAt: now,
      ),
    ]);

    batch.insertAll(database.taskTable, [
      TaskTableCompanion.insert(
        id: uuid.v4(),
        boardId: boardId,
        columnId: todoColumnId,
        title: 'Explore LozaLife',
        description: const Value(
          'Tap a task to edit it, drag cards between columns, '
          'use the search bar to filter tasks by title.',
        ),
        order: 0,
        createdAt: now,
        updatedAt: now,
      ),
      TaskTableCompanion.insert(
        id: uuid.v4(),
        boardId: boardId,
        columnId: todoColumnId,
        title: 'Create your first board',
        order: 1,
        createdAt: now,
        updatedAt: now,
      ),
      TaskTableCompanion.insert(
        id: uuid.v4(),
        boardId: boardId,
        columnId: inProgressColumnId,
        title: 'Try drag & drop',
        description: const Value('Long-press a card and move it around.'),
        deadline: Value(now.add(const Duration(days: 3))),
        order: 0,
        createdAt: now,
        updatedAt: now,
      ),
      TaskTableCompanion.insert(
        id: uuid.v4(),
        boardId: boardId,
        columnId: doneColumnId,
        title: 'Install the app',
        order: 0,
        createdAt: now,
        updatedAt: now,
      ),
    ]);
  });
}
