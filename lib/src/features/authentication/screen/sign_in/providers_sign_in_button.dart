import 'package:flutter/material.dart';

import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

class SliverAuthProviderSignInButton extends StatelessWidget {
  const SliverAuthProviderSignInButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.isLoading,
    required this.providerIcon,
  });

  final String text;
  final VoidCallback? onPressed;
  final Widget providerIcon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final content = isLoading
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
    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      padding: const EdgeInsets.only(
        right: Sizes.p16,
        left: Sizes.p16,
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        child: content,
      ),
    );
  }
}
