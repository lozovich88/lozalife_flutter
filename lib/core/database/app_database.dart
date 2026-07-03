import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:lozalife/core/database/daos/board_dao.dart';
import 'package:lozalife/core/database/daos/column_dao.dart';
import 'package:lozalife/core/database/daos/task_dao.dart';
import 'package:lozalife/core/database/seed.dart';
import 'package:lozalife/core/database/tables.dart';

part 'app_database.g.dart';

/// Single source of truth for the whole application.
///
/// The UI only ever observes this database through Drift streams. Stage 2
/// sync will apply server updates directly here, which automatically
/// refreshes every open screen.
@DriftDatabase(
  tables: [BoardTable, ColumnTable, TaskTable],
  daos: [BoardDao, ColumnDao, TaskDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator migrator) async {
          await migrator.createAll();
          await seedDatabase(this);
        },
      );

  static QueryExecutor _openConnection() =>
      driftDatabase(name: 'lozalife.sqlite');
}
