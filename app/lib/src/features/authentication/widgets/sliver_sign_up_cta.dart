import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/features/authentication/screens/sign_up/sign_up_controller.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_cta_button.dart';

class SignUpSliverCtaButton extends ConsumerWidget {
  const SignUpSliverCtaButton({
    super.key,
    this.onPressed,
  });

  static const signUpButtonKey = Key('signUpButton');

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSigningUp = ref.watch(signUpControllerProvider).isLoading;
    final loc = context.loc;
    return IgnorePointer(
      ignoring: isSigningUp,
      child: SliverCTAButton(
        key: signUpButtonKey,
        buttonType: ButtonType.primary,
        text: loc.signUpButtonTitle,
        isLoading: isSigningUp,
        onPressed: isSigningUp ? () {} : onPressed,
      ),
    );
  }
}
