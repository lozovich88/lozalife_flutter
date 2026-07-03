/// Central place for all layout constants. No magic numbers in widgets.
abstract final class AppDimens {
  /// Screens wider than this show the permanent boards panel.
  static const double wideLayoutBreakpoint = 900;

  /// Width of the permanent boards panel on wide screens.
  static const double boardsPanelWidth = 300;

  /// Fixed width of a single column on the board.
  static const double boardColumnWidth = 300;

  static const double size2 = 2;
  static const double size4 = 4;
  static const double size8 = 8;
  static const double size12 = 12;
  static const double size16 = 16;
  static const double size24 = 24;
  static const double size32 = 32;
  static const double size48 = 48;

  static const double cardRadius = 12;
  static const double sheetRadius = 16;

  /// Max lines of the description preview on a task card.
  static const int taskDescriptionMaxLines = 3;
}
