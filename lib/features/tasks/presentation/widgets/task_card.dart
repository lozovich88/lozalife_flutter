import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:lozalife/core/design_system/app_card.dart';
import 'package:lozalife/core/design_system/app_deadline_chip.dart';
import 'package:lozalife/core/theme/app_dimens.dart';
import 'package:lozalife/features/tasks/domain/models/task_model.dart';

/// Compact task card shown inside a board column.
class TaskCard extends StatelessWidget {
  final TaskModel task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String? description = task.description;
    final DateTime? deadline = task.deadline;

    return AppCard(
      // Full column width: no horizontal margins inside the column.
      margin: const EdgeInsets.symmetric(vertical: AppDimens.size4),
      onTap: () => context.push('/task/${task.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: textTheme.titleSmall,
          ),
          if (description != null && description.isNotEmpty) ...[
            const SizedBox(height: AppDimens.size4),
            Text(
              description,
              maxLines: AppDimens.taskDescriptionMaxLines,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodySmall,
            ),
          ],
          if (deadline != null) ...[
            const SizedBox(height: AppDimens.size8),
            AppDeadlineChip(deadline: deadline),
          ],
        ],
      ),
    );
  }
}
