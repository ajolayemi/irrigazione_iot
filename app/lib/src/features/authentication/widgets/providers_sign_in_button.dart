import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/authentication/screens/sign_in/sign_in_controller.dart';
import 'package:irrigazione_iot/src/utils/custom_controller_state.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_center.dart';

/// A sliver button that signs in with an authentication provider
/// such as Google, Facebook, or Apple.
class SliverAuthProviderSignInButton extends ConsumerWidget {
  const SliverAuthProviderSignInButton({
    super.key,
    required this.text,
    required this.providerIcon,
    required this.buttonStateKey,
    this.onPressed,
  });

  final String text;
  final String buttonStateKey;
  final VoidCallback? onPressed;
  final Widget providerIcon;

  static const signInWithAuthProviderKey = Key('signInWithAuthProviderKey');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thisButtonIsLoading = ref
        .watch(signInControllerProvider)
        .stateWithIdIsLoading(buttonStateKey);
    final globalLoadingState =
        ref.watch(signInControllerProvider).isGlobalLoading;
    final content = thisButtonIsLoading
        ? const CircularProgressIndicator.adaptive()
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              providerIcon,
              gapW16,
              Text(text,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.theme.primaryColor,
                  ))
            ],
          );
    return IgnorePointer(
      key: signInWithAuthProviderKey,
      ignoring: globalLoadingState,
      child: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        padding: const EdgeInsets.only(
          right: Sizes.p16,
          left: Sizes.p16,
        ),
        child: OutlinedButton(
          onPressed: onPressed,
          child: content,
        ),
      ),
    );
  }
}
