import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'package:lozalife/core/database/app_database.dart';
import 'package:lozalife/features/boards/data/datasource/board_mapper.dart';
import 'package:lozalife/features/boards/domain/models/board_model.dart';
import 'package:lozalife/features/boards/domain/repository/board_repository.dart';

/// Drift-backed implementation of [BoardRepository].
///
/// Stateless by design: every method either mutates the database or exposes
/// a stream over it. Stage 2 will additionally enqueue each mutation into
/// the pending-operations sync queue (see `core/sync`).
class BoardRepositoryImpl implements BoardRepository {
  static const String _defaultColumnName = 'To Do';
  static const int _defaultBoardColor = 0xFF3F51B5;

  final AppDatabase _database;
  final Uuid _uuid;

  BoardRepositoryImpl(this._database, [this._uuid = const Uuid()]);

  @override
  Stream<List<BoardModel>> watchBoardsStream() =>
      _database.boardDao.watchBoards().map(
            (rows) => rows.map(mapBoardRowToModel).toList(),
          );

  @override
  Stream<Map<String, int>> watchTaskCountsStream() =>
      _database.boardDao.watchTaskCounts();

  @override
  Stream<BoardModel?> watchBoardStream(String boardId) =>
      _database.boardDao.watchBoard(boardId).map(
            (row) => row == null ? null : mapBoardRowToModel(row),
          );

  @override
  Future<String> createBoard(String name) async {
    final String boardId = _uuid.v4();
    final DateTime now = DateTime.now();
    final int maxOrder = await _database.boardDao.getMaxOrder();

    await _database.transaction(() async {
      await _database.boardDao.insertBoard(
        BoardTableCompanion.insert(
          id: boardId,
          name: name,
          color: _defaultBoardColor,
          order: maxOrder + 1,
          createdAt: now,
          updatedAt: now,
        ),
      );
      await _database.columnDao.insertColumn(
        ColumnTableCompanion.insert(
          id: _uuid.v4(),
          boardId: boardId,
          name: _defaultColumnName,
          order: 0,
          createdAt: now,
          updatedAt: now,
        ),
      );
    });
    // TODO(sync): enqueue BoardCreated + ColumnCreated operations (Stage 2).
    return boardId;
  }

  @override
  Future<void> renameBoard(String boardId, String name) async {
    await _database.boardDao.updateBoard(
      boardId,
      BoardTableCompanion(
        name: Value(name),
        updatedAt: Value(DateTime.now()),
      ),
    );
    // TODO(sync): enqueue BoardRenamed operation (Stage 2).
  }

  @override
  Future<void> setPinned(String boardId, bool isPinned) async {
    await _database.boardDao.updateBoard(
      boardId,
      BoardTableCompanion(
        isPinned: Value(isPinned),
        updatedAt: Value(DateTime.now()),
      ),
    );
    // TODO(sync): enqueue BoardUpdated operation (Stage 2).
  }

  @override
  Future<void> deleteBoard(String boardId) async {
    final DateTime now = DateTime.now();
    await _database.boardDao.updateBoard(
      boardId,
      BoardTableCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
    // TODO(sync): enqueue BoardDeleted operation (Stage 2).
  }
}
