import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/exceptions/app_exception.dart';
import 'package:irrigazione_iot/src/features/authentication/screens/sign_in/sign_in_controller.dart';
import 'package:irrigazione_iot/src/features/authentication/screens/sign_in/sign_in_screen_contents.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to controller state for when error occurs
    ref.listen(
      signInControllerProvider,
      (_, state) {
        if (state.error is! UserNotFoundException) {
          return state.showAlertDialogOnError(context);
        }
        debugPrint('User not found error occurred in sign in screen');
      },
    );
    return Scaffold(
      appBar: AppBar(),
      body: const SignInScreenContents(),
    );
  }
}
