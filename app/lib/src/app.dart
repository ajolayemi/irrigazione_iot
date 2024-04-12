import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/routes/app_router.dart';
import 'config/theme/app_theme.dart';
import 'settings/settings_controller.dart';
import 'utils/extensions.dart';

/// The Widget that configures your application.
class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeConfig = ref.watch(goRouterProvider);
    final settingsController = ref.watch(settingsControllerProvider);
    return MaterialApp.router(
      routerConfig: routeConfig,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      darkTheme: ThemeData.dark(),
      themeMode: settingsController.themeMode,
      onGenerateTitle: (BuildContext context) => context.loc.appTitle,
    );
  }
}
