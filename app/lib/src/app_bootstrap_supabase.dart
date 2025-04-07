import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/app_bootstrap.dart';
import 'package:irrigazione_iot/src/exceptions/async_error_logger.dart';
import 'package:irrigazione_iot/src/settings/settings_controller.dart';

/// Extension methods specific for real Supabase project configuration
extension AppBootstrapSupabase on AppBootstrap {
  /// Creates the top-level [ProviderContainer] by overriding providers with fake
  /// repositories only. This is useful for testing purposes and for running the
  /// app with a real supabase backend.
  ///
  /// Note: all repositories needed by the app can be accessed via providers.
  /// Some of these providers throw an [UnimplementedError] by default.
  ///
  /// Example:
  /// ```dart
  ///@riverpod
  /// SettingsController settingsController(settingsControllerRef) {
  ///   throw UnimplementedError();
  /// }
  /// ```
  ///
  /// As a result, this method does two things:
  /// - create and configure the repositories as desired
  /// - override the default implementations with a list of "overrides"
  Future<ProviderContainer> createSupabaseProviderContainer(
      {bool addDelay = true}) async {
    final settingsController = await bootSettingsController();
    // final localMqttSuffix = LocalMqttTopicsSuffix();
    return ProviderContainer(
      overrides: [
        // mqttTopicsSuffixProvider.overrideWithValue(localMqttSuffix),
        // services
        settingsControllerProvider.overrideWithValue(settingsController),
      ],
      observers: [
        AsyncErrorLogger(),
      ],
    );
  }
}
