import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../exceptions/app_exception.dart';
import 'sign_up_controller.dart';
import 'sign_up_screen_contents.dart';
import '../../../../utils/async_value_ui.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to controller state for when error occurs
    ref.listen(signUpControllerProvider, (_, state) {
      if (state.error is! EmailAlreadyInUseException) {
        return state.showAlertDialogOnError(context);
      } 
      debugPrint('Email already in use error occurred in sign up screen');
    });
    return const Scaffold(
      body: SignUpScreenContents(),
    );
  }
}
