import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:lozalife/core/theme/app_dimens.dart';
import 'package:lozalife/features/tasks/domain/models/task_model.dart';
import 'package:lozalife/features/tasks/presentation/widgets/task_card.dart';

/// Makes a [TaskCard] draggable so it can be reordered inside a column and
/// moved across columns. The drop handling lives in the column widget.
///
/// On touch platforms the drag starts with a long press (a plain drag must
/// keep scrolling the list); on desktop and web it starts immediately with
/// the mouse.
class DraggableTaskCard extends StatelessWidget {
  static const double _dragFeedbackOpacity = 0.9;
  static const double _childWhenDraggingOpacity = 0.3;

  final TaskModel task;

  const DraggableTaskCard({super.key, required this.task});

  bool get _isTouchPlatform {
    if (kIsWeb) {
      return false;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return true;
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget feedback = Opacity(
      opacity: _dragFeedbackOpacity,
      child: SizedBox(
        width: AppDimens.boardColumnWidth - AppDimens.size16,
        child: Material(
          color: Colors.transparent,
          child: TaskCard(task: task),
        ),
      ),
    );
    final Widget childWhenDragging = Opacity(
      opacity: _childWhenDraggingOpacity,
      child: TaskCard(task: task),
    );
    final Widget child = TaskCard(task: task);

    if (_isTouchPlatform) {
      return LongPressDraggable<TaskModel>(
        data: task,
        feedback: feedback,
        childWhenDragging: childWhenDragging,
        child: child,
      );
    }
    return Draggable<TaskModel>(
      data: task,
      feedback: feedback,
      childWhenDragging: childWhenDragging,
      child: child,
    );
  }
}
