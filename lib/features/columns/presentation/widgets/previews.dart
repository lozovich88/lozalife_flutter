import 'package:flutter/material.dart';

import 'package:lozalife/features/columns/presentation/widgets/board_column.dart';
import 'package:lozalife/features/columns/presentation/widgets/column_drop_zone.dart';
import 'package:lozalife/features/tasks/presentation/widgets/task_card.dart';
import 'package:lozalife/shared/previews/app_preview.dart';
import 'package:lozalife/shared/previews/preview_data.dart';

/// Widget previews for the columns feature.
///
/// Run with `flutter widget-preview start`.

const String _group = 'Columns';

@AppPreview(name: 'Board column', group: _group, size: Size(340, 520))
Widget boardColumnPreview() => BoardColumn(
      column: previewColumns.first,
      allColumns: previewColumns,
    );

@AppPreview(name: 'Drop zone with card', group: _group, size: Size(320, 160))
Widget columnDropZonePreview() => ColumnDropZone(
      onAccept: (task) {},
      child: TaskCard(task: previewTasks.first),
    );

@AppPreview(name: 'Tail drop zone', group: _group, size: Size(320, 120))
Widget tailColumnDropZonePreview() => ColumnDropZone(
      isTail: true,
      onAccept: (task) {},
    );
