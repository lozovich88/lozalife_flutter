import 'package:lozalife/core/database/app_database.dart';
import 'package:lozalife/features/columns/domain/models/column_model.dart';

/// Maps a Drift row to the domain model.
ColumnModel mapColumnRowToModel(ColumnTableData row) => ColumnModel(
      id: row.id,
      boardId: row.boardId,
      name: row.name,
      order: row.order,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      deletedAt: row.deletedAt,
    );
