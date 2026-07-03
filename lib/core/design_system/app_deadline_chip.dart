import 'package:flutter/material.dart';

import 'package:lozalife/core/theme/app_dimens.dart';

/// Compact deadline label with a clock icon. Turns red when overdue.
class AppDeadlineChip extends StatelessWidget {
  final DateTime deadline;

  const AppDeadlineChip({super.key, required this.deadline});

  bool get _isOverdue => deadline.isBefore(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color color =
        _isOverdue ? colorScheme.error : colorScheme.onSurfaceVariant;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.schedule,
          size: AppDimens.size16,
          color: color,
        ),
        const SizedBox(width: AppDimens.size4),
        Text(
          MaterialLocalizations.of(context).formatShortDate(deadline),
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: color),
        ),
      ],
    );
  }
}
