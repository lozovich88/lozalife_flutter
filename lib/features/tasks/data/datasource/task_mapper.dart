import 'package:lozalife/core/database/app_database.dart';
import 'package:lozalife/features/tasks/domain/models/task_model.dart';

/// Maps a Drift row to the domain model.
TaskModel mapTaskRowToModel(TaskTableData row) => TaskModel(
      id: row.id,
      boardId: row.boardId,
      columnId: row.columnId,
      title: row.title,
      description: row.description,
      deadline: row.deadline,
      order: row.order,
      parentTaskId: row.parentTaskId,
      isArchived: row.isArchived,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      deletedAt: row.deletedAt,
    );
