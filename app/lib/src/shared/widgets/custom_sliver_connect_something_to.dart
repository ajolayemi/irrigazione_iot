import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/shared/widgets/async_value_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

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
  });

  final String title;
  final AsyncValueSliverWidget child;
  final List<Widget>? actions;
  final VoidCallback? onCTAPressed;
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
