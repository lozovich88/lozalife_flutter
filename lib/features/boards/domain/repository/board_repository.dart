import 'package:lozalife/features/boards/domain/models/board_model.dart';

/// Boards contract for the presentation layer.
///
/// Implementations are stateless: they only mutate the local database.
/// The UI observes changes exclusively through the `watch*` streams.
abstract interface class BoardRepository {
  /// Alive boards: pinned first, then by manual order.
  Stream<List<BoardModel>> watchBoardsStream();

  /// Number of alive tasks per board id (for board cards).
  Stream<Map<String, int>> watchTaskCountsStream();

  Stream<BoardModel?> watchBoardStream(String boardId);

  /// Creates a board together with the default "To Do" column and
  /// returns the new board id.
  Future<String> createBoard(String name);

  Future<void> renameBoard(String boardId, String name);

  Future<void> setPinned(String boardId, bool isPinned);

  Future<void> deleteBoard(String boardId);
}
