import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/enums/button_types.dart';
import '../config/routes/routes_enums.dart';
import '../constants/app_sizes.dart';
import '../utils/extensions.dart';
import 'app_cta_button.dart';

/// Placeholder widget showing a message and CTA to go back to the home screen.
class EmptyPlaceholderWidget extends StatelessWidget {
  const EmptyPlaceholderWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: context.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            gapH32,
            CTAButton(
              buttonType: ButtonType.primary,
              onPressed: () => context.goNamed(AppRoute.home.name),
              text: 'Go Home',
            )
          ],
        ),
      ),
    );
  }
}
