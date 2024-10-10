import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/weenat/controllers/weenat_auth_controller.dart';
import 'package:irrigazione_iot/src/features/weenat/screens/weenat_auth_screen_contents.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';

class WeenatAuthScreen extends ConsumerWidget {
  const WeenatAuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      weenatAuthControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final isLoading = ref.watch(weenatAuthControllerProvider).isLoading;
    return PopScope(
      canPop: !isLoading,
      onPopInvoked: (didPop) {
        if (didPop) {
          debugPrint('User exited Weenat auth screen');
        } else {
          debugPrint('User tried to exit Weenat auth screen');
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: const WeenatAuthScreenContents(),
      ),
    );
  }
}
