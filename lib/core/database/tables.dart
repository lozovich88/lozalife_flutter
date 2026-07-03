import 'package:drift/drift.dart';

/// Boards table. `deletedAt` implements soft delete so that Stage 2 sync can
/// propagate deletions to the server before physically removing rows.
class BoardTable extends Table {
  @override
  String get tableName => 'boards';

  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get color => integer()();
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();
  IntColumn get order => integer().named('sort_order')();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Columns of a board.
class ColumnTable extends Table {
  @override
  String get tableName => 'board_columns';

  TextColumn get id => text()();
  TextColumn get boardId => text()();
  TextColumn get name => text()();
  IntColumn get order => integer().named('sort_order')();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Tasks table. `parentTaskId` and `isArchived` are reserved for Stage 3
/// (subtasks and archive) and are not used by the MVP UI yet.
class TaskTable extends Table {
  @override
  String get tableName => 'tasks';

  TextColumn get id => text()();
  TextColumn get boardId => text()();
  TextColumn get columnId => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get deadline => dateTime().nullable()();
  IntColumn get order => integer().named('sort_order')();
  TextColumn get parentTaskId => text().nullable()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
