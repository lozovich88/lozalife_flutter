import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lozalife/core/theme/app_durations.dart';

/// Debounced search query for the currently opened board.
///
/// The raw text field input goes through [setQuery]; the state (and therefore
/// the SQL query) only updates after [AppDurations.searchDebounce] of
/// inactivity, so the database is not hit on every keystroke.
class BoardSearchQueryNotifier extends Notifier<String> {
  Timer? _debounceTimer;

  @override
  String build() {
    ref.onDispose(() => _debounceTimer?.cancel());
    return '';
  }

  void setQuery(String rawInput) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(AppDurations.searchDebounce, () {
      state = rawInput.trim();
    });
  }

  void clear() {
    _debounceTimer?.cancel();
    state = '';
  }
}

final NotifierProvider<BoardSearchQueryNotifier, String>
    boardSearchQueryProvider =
    NotifierProvider<BoardSearchQueryNotifier, String>(
  BoardSearchQueryNotifier.new,
);
