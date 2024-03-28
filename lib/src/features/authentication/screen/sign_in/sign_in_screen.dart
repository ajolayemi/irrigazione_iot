import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/authentication/screen/sign_in/sign_in_controller.dart';
import 'package:irrigazione_iot/src/features/authentication/screen/sign_in/sign_in_screen_contents.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to controller state for when error occurs
    ref.listen(
      signInControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    return const Scaffold(
      body: SignInScreenContents(),
    );
  }
}
