// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_dao.dart';

// ignore_for_file: type=lint
mixin _$BoardDaoMixin on DatabaseAccessor<AppDatabase> {
  $BoardTableTable get boardTable => attachedDatabase.boardTable;
  $TaskTableTable get taskTable => attachedDatabase.taskTable;
  BoardDaoManager get managers => BoardDaoManager(this);
}

class BoardDaoManager {
  final _$BoardDaoMixin _db;
  BoardDaoManager(this._db);
  $$BoardTableTableTableManager get boardTable =>
      $$BoardTableTableTableManager(_db.attachedDatabase, _db.boardTable);
  $$TaskTableTableTableManager get taskTable =>
      $$TaskTableTableTableManager(_db.attachedDatabase, _db.taskTable);
}
