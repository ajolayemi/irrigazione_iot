import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../exceptions/app_exception.dart';
import 'sign_in_controller.dart';
import 'sign_in_screen_contents.dart';
import '../../../../utils/async_value_ui.dart';

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
    return const Scaffold(
      body: SignInScreenContents(),
    );
  }
}
