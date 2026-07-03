import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lozalife/core/design_system/app_async_states.dart';
import 'package:lozalife/core/design_system/app_buttons.dart';
import 'package:lozalife/core/localization/l10n.dart';
import 'package:lozalife/core/theme/app_dimens.dart';
import 'package:lozalife/features/boards/presentation/widgets/board_search_bar.dart';
import 'package:lozalife/features/columns/domain/models/column_model.dart';
import 'package:lozalife/features/columns/presentation/actions/column_actions.dart';
import 'package:lozalife/features/columns/presentation/providers/column_providers.dart';
import 'package:lozalife/features/columns/presentation/providers/visible_columns_provider.dart';
import 'package:lozalife/features/columns/presentation/widgets/board_column.dart';
import 'package:lozalife/features/tasks/presentation/state/board_search_state.dart';

/// Body of the board screen: search bar plus horizontally scrolling columns
/// and the trailing "add column" button.
class BoardContent extends ConsumerWidget {
  final String boardId;

  const BoardContent({super.key, required this.boardId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<ColumnModel>> visibleColumns =
        ref.watch(visibleColumnsProvider(boardId));
    final List<ColumnModel> allColumns =
        ref.watch(columnsStreamProvider(boardId)).value ??
            const <ColumnModel>[];
    final bool isSearching =
        ref.watch(boardSearchQueryProvider).isNotEmpty;

    return Column(
      children: [
        const BoardSearchBar(),
        Expanded(
          child: visibleColumns.when(
            loading: () => const AppLoadingState(),
            error: (error, stackTrace) => AppErrorState(
              message: context.l10n.failedToLoadColumns('$error'),
            ),
            data: (columns) {
              if (columns.isEmpty && isSearching) {
                return AppEmptyState(message: context.l10n.noTasksFound);
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(AppDimens.size8),
                // One extra slot for the "add column" button.
                itemCount: columns.length + 1,
                itemBuilder: (listContext, index) {
                  if (index == columns.length) {
                    return _AddColumnButton(
                      onPressed: () =>
                          showCreateColumnDialog(listContext, ref, boardId),
                    );
                  }
                  return BoardColumn(
                    column: columns[index],
                    allColumns: allColumns,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AddColumnButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddColumnButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.size8),
      child: SizedBox(
        width: AppDimens.boardColumnWidth / 2,
        child: AppOutlinedIconButton(
          icon: Icons.add,
          label: context.l10n.addColumnAction,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
