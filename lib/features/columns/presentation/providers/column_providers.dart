import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lozalife/core/database/database_provider.dart';
import 'package:lozalife/features/columns/data/repository/column_repository_impl.dart';
import 'package:lozalife/features/columns/domain/models/column_model.dart';
import 'package:lozalife/features/columns/domain/repository/column_repository.dart';

final Provider<ColumnRepository> columnRepositoryProvider =
    Provider<ColumnRepository>(
  (ref) => ColumnRepositoryImpl(ref.watch(appDatabaseProvider)),
);

/// Alive columns of a board, ordered by manual order.
final columnsStreamProvider = StreamProvider.family<List<ColumnModel>, String>(
  (ref, boardId) =>
      ref.watch(columnRepositoryProvider).watchColumnsStream(boardId),
);
