import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/or_with_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_center.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final colorScheme = context.colorScheme;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
            ),
          ),
          gapH64,
          ResponsiveCenter(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
            maxContentWidth: Breakpoint.tablet,
            child: CTAButton(
              text: loc.loginToYourAccount,
              buttonType: ButtonType.primary,
              onPressed: () => context.pushNamed(AppRoute.signIn.name),
            ),
          ),
    
          OrWithWidget(orText: loc.or),
          ResponsiveCenter(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
            maxContentWidth: Breakpoint.tablet,
            child: CTAButton(
              text: loc.registerYourCompany,
              buttonType: ButtonType.secondary,
              onPressed: () => context.pushNamed(AppRoute.registerCompany.name),
            ),
          ),
          gapH64,
        ],
      ),
    );
  }
}
