import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/enums/button_types.dart';
import '../screen/sign_up/sign_up_controller.dart';
import '../../../utils/extensions.dart';
import '../../../widgets/app_cta_button.dart';

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
