import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_text_button.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(loc.noAccountText),
        gapW4,
        CustomTextButton(
          onPressed: () => context.goNamed(
            AppRoute.signUp.name,
          ),
          text: loc.signUpText,
        )
      ],
    );
  }
}
