import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lozalife/core/localization/l10n.dart';
import 'package:lozalife/core/router/app_router.dart';
import 'package:lozalife/core/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: LozaLifeApp(),
    ),
  );
}

class LozaLifeApp extends ConsumerWidget {
  const LozaLifeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      onGenerateTitle: (titleContext) => titleContext.l10n.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
