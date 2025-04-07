import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

/// A base sliver scaffold to be used in pages where user makes a connection between two entities.
/// For example, connecting a pump to a sector, a board to a collector, selecting a variety for a sector and so on
class CustomSliverConnectSomethingTo extends StatelessWidget {
  const CustomSliverConnectSomethingTo({
    super.key,
    required this.title,
    required this.child,
    this.actions,
    this.onCTAPressed,
    this.ctaAlternativeText,
    this.subChild,
  });

  /// Title of the screen
  final String title;

  /// The main content of the screen
  final Widget child;

  /// A widget (which is meant to be a text field to search for items)
  /// to be displayed at the top of the screen, right after the title
  final Widget? subChild;

  /// Actions to be displayed in the app bar
  final List<Widget>? actions;

  /// Function to execute when the CTA button is pressed
  final VoidCallback? onCTAPressed;

  /// Alternative text for the CTA button
  final String? ctaAlternativeText;
  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return Scaffold(
      body: PaddedSafeArea(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p12),
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  AppSliverBar(
                    title: title,
                    actions: actions,
                  ),
                  subChild ?? const SliverToBoxAdapter(),
                  child,
                ],
              ),
            ),
            SliverCTAButton(
              text: ctaAlternativeText ?? loc.genericConfirmButtonLabel,
              buttonType: ButtonType.primary,
              onPressed: onCTAPressed,
            ),
            gapH32,
          ],
        ),
      ),
    );
  }
}
