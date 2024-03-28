import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/widgets/custom_text_button.dart';

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
          onPressed: () => showNotImplementedAlertDialog(context: context),
          text: loc.signUpText,
        )
      ],
    );
  }
}
