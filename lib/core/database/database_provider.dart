import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lozalife/core/database/app_database.dart';

/// Application-wide database instance. Lives as long as the app does.
final Provider<AppDatabase> appDatabaseProvider = Provider<AppDatabase>(
  (ref) {
    final AppDatabase database = AppDatabase();
    ref.onDispose(database.close);
    return database;
  },
);
