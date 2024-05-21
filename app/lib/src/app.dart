import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/config/theme/app_theme.dart';
import 'package:irrigazione_iot/src/localization/app_localizations.dart';
import 'package:irrigazione_iot/src/settings/settings_controller.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

/// The Widget that configures your application.
class IotIrrigationApp extends ConsumerWidget {
  const IotIrrigationApp({super.key});

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
