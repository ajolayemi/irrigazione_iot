import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/application/di/service_locator.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:irrigazione_iot/src/app.dart';
import 'package:irrigazione_iot/src/exceptions/error_logger.dart';
import 'package:irrigazione_iot/src/shared/providers/shared_prefs_provider.dart';
import 'package:irrigazione_iot/src/settings/settings_controller.dart';
import 'package:irrigazione_iot/src/settings/settings_service.dart';

/// Helper class to initialize services and configure the error handlers
class AppBootstrap {
  /// Create the root widget that should be passed to [runApp]
  Future<Widget> createRootWidget(
      {required ProviderContainer container}) async {
    // Register the timeago messages
    registerTimeagoMessages();

    // * Register error handlers. For more info, see:
    // * https://docs.flutter.dev/testing/errors
    final errorLogger = container.read(errorLoggerProvider);
    registerErrorHandlers(errorLogger);

    // Load the SharedPreferences instance during initialization
    await container.read(sharedPreferencesProvider.future);

      ServiceLocator.init();

    return UncontrolledProviderScope(
      container: container,
      child: const IotIrrigationApp(),
    );
  }

  void registerTimeagoMessages() {
    // Register italian timeago messages
    timeago.setLocaleMessages('it', timeago.ItMessages());
    timeago.setLocaleMessages('it_short', timeago.ItShortMessages());
  }

  Future<SettingsController> bootSettingsController() async {
    // Set up the SettingsController, which will glue user settings to multiple
    // Flutter Widgets.
    final settingsController = SettingsController(SettingsService());

    // Load the user's preferred theme while the splash screen is displayed.
    // This prevents a sudden theme change when the app is first displayed.
    await settingsController.loadSettings();

    return settingsController;
  }

  // Register Flutter error handlers
  void registerErrorHandlers(ErrorLogger errorLogger) {
    // * Show some error UI if any uncaught exception happens
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      errorLogger.logError(details.exception, details.stack);
    };
    // * Handle errors from the underlying platform/OS
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      errorLogger.logError(error, stack);
      return true;
    };
    // * Show some error UI when any widget in the app fails to build
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('An error occurred'),
        ),
        body: Center(child: Text(details.toString())),
      );
    };
  }
}
