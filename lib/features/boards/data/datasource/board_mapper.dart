import 'package:lozalife/core/database/app_database.dart';
import 'package:lozalife/features/boards/domain/models/board_model.dart';

/// Maps a Drift row to the domain model.
BoardModel mapBoardRowToModel(BoardTableData row) => BoardModel(
      id: row.id,
      name: row.name,
      color: row.color,
      isPinned: row.isPinned,
      order: row.order,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      deletedAt: row.deletedAt,
    );
