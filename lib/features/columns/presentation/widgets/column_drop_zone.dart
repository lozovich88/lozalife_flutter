import 'package:flutter/material.dart';

import 'package:lozalife/core/theme/app_dimens.dart';
import 'package:lozalife/features/tasks/domain/models/task_model.dart';

/// Drop target used for drag&drop inside a column.
///
/// When wrapping a task card, dropping onto it inserts the dragged task at
/// this position. The tail variant (no [child]) fills the remaining space
/// below the last task and accepts drops at the end of the column.
class ColumnDropZone extends StatelessWidget {
  static const double _tailMinHeight = 80;
  static const double _indicatorHeight = AppDimens.size4;

  final Widget? child;
  final bool isTail;
  final ValueChanged<TaskModel> onAccept;

  const ColumnDropZone({
    super.key,
    this.child,
    this.isTail = false,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return DragTarget<TaskModel>(
      onAcceptWithDetails: (details) => onAccept(details.data),
      builder: (targetContext, candidateData, rejectedData) {
        final bool isHovered = candidateData.isNotEmpty;
        if (isTail) {
          return Container(
            constraints: const BoxConstraints(minHeight: _tailMinHeight),
            decoration: BoxDecoration(
              color: isHovered
                  ? colorScheme.primaryContainer.withValues(alpha: 0.4)
                  : null,
              borderRadius: BorderRadius.circular(AppDimens.cardRadius),
            ),
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: isHovered ? _indicatorHeight * 8 : 0,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(AppDimens.cardRadius),
              ),
            ),
            ?child,
          ],
        );
      },
    );
  }
}
