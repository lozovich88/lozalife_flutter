import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lozalife/core/localization/l10n.dart';
import 'package:lozalife/core/theme/app_theme.dart';
import 'package:lozalife/features/boards/presentation/providers/board_providers.dart';
import 'package:lozalife/features/columns/presentation/providers/column_providers.dart';
import 'package:lozalife/features/tasks/presentation/providers/task_providers.dart';
import 'package:lozalife/shared/previews/preview_repositories.dart';

/// Shared preview annotation: applies the app theme, localizations and a
/// Riverpod scope where the Drift-backed repositories are replaced with
/// in-memory fakes serving static demo data.
///
/// Usage: annotate a public top-level function returning a [Widget].
/// Run the previewer with `flutter widget-preview start`.
final class AppPreview extends Preview {
  const AppPreview({
    super.name,
    super.group,
    super.size,
    super.brightness,
  }) : super(
          wrapper: wrapPreview,
          theme: buildPreviewTheme,
          localizations: buildPreviewLocalizations,
        );
}

/// Injects fake repositories and a Material ancestor for bare widgets.
Widget wrapPreview(Widget child) {
  return ProviderScope(
    overrides: [
      boardRepositoryProvider.overrideWith((ref) => PreviewBoardRepository()),
      columnRepositoryProvider
          .overrideWith((ref) => PreviewColumnRepository()),
      taskRepositoryProvider.overrideWith((ref) => PreviewTaskRepository()),
    ],
    child: Material(
      color: Colors.transparent,
      child: child,
    ),
  );
}

PreviewThemeData buildPreviewTheme() => PreviewThemeData(
      materialLight: AppTheme.lightTheme,
      materialDark: AppTheme.darkTheme,
    );

PreviewLocalizationsData buildPreviewLocalizations() =>
    PreviewLocalizationsData(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
