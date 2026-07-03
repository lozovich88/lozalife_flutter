import 'package:flutter/widgets.dart';

import 'package:lozalife/l10n/generated/app_localizations.dart';

export 'package:lozalife/l10n/generated/app_localizations.dart';

/// Shorthand access to the generated localizations:
/// `context.l10n.someString` instead of `AppLocalizations.of(context)`.
extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
