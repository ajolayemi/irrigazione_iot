import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/shared/providers/app_startup_provider.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/error_message_widget.dart';

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({
    super.key,
    required this.onLoaded,
  });

  // Main widget to return after startup logic has been loaded
  final Widget onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
        data: (_) => onLoaded,
        error: (e, st) => AppStartupErrorWidget(
              message: e.toString(),
              onRetry: () => ref.invalidate(appStartupProvider),
            ),
        loading: () => const AppStartupLoadingWidget());
  }
}

// Widget to show while app initialization is ongoing
class AppStartupLoadingWidget extends StatelessWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

/// Widget to show if app initialization fails
class AppStartupErrorWidget extends StatelessWidget {
  const AppStartupErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ErrorMessageWidget(message),
            CTAButton(
              text: 'Riprova',
              buttonType: ButtonType.primary,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
