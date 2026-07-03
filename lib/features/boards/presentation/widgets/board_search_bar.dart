import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lozalife/core/design_system/app_search_field.dart';
import 'package:lozalife/core/localization/l10n.dart';
import 'package:lozalife/features/tasks/presentation/state/board_search_state.dart';

/// Search input for filtering tasks of the current board by title.
///
/// The raw input is debounced inside [BoardSearchQueryNotifier]; the actual
/// filtering happens in SQLite via a LIKE query.
class BoardSearchBar extends ConsumerStatefulWidget {
  const BoardSearchBar({super.key});

  @override
  ConsumerState<BoardSearchBar> createState() => _BoardSearchBarState();
}

class _BoardSearchBarState extends ConsumerState<BoardSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    ref.read(boardSearchQueryProvider.notifier).setQuery(value);
    setState(() {});
  }

  void _clear() {
    _controller.clear();
    ref.read(boardSearchQueryProvider.notifier).clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AppSearchField(
      controller: _controller,
      hint: context.l10n.searchTasksHint,
      onChanged: _onChanged,
      onClear: _clear,
    );
  }
}
