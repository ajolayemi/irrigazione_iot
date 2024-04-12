import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/enums/button_types.dart';
import '../screen/sign_in/sign_in_controller.dart';
import '../../../utils/custom_controller_state.dart';
import '../../../utils/extensions.dart';
import '../../../widgets/app_cta_button.dart';

class SignInSliverCtaButton extends ConsumerWidget {
  const SignInSliverCtaButton({
    super.key,
    required this.onPressed,
  });

  static const signInButtonKey = Key('signInButton');

  static const stateKey = SignInController.signInStateKey;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thisButtonIsLoading =
        ref.watch(signInControllerProvider).stateWithIdIsLoading(stateKey);
    final globalLoadingState =
        ref.watch(signInControllerProvider).isGlobalLoading;
    final loc = context.loc;
    return IgnorePointer(
      ignoring: globalLoadingState,
      child: SliverCTAButton(
        key: signInButtonKey,
        buttonType: ButtonType.primary,
        text: loc.signInButtonTitle,
        isLoading: thisButtonIsLoading,
        onPressed: globalLoadingState ? () {} : onPressed,
      ),
    );
  }
}
