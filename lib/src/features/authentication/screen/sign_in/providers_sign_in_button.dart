import 'package:flutter/material.dart';

import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

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
    return OutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: isLoading
            ? [
                const CircularProgressIndicator(),
              ]
            : [
                providerIcon,
                gapW16,
                Text(
                  text,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.theme.primaryColor,
                  ),
                ),
              ],
      ),
    );
  }
}
