/// Central place for all timing constants.
abstract final class AppDurations {
  /// Debounce applied to the board search query before hitting the database.
  static const Duration searchDebounce = Duration(milliseconds: 300);

  /// Debounce applied to auto-saving task fields while the user types.
  static const Duration autosaveDebounce = Duration(milliseconds: 500);
}
