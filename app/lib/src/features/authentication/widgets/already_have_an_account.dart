import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/routes/routes_enums.dart';
import '../../../constants/app_sizes.dart';
import '../../../utils/extensions.dart';
import '../../../widgets/custom_text_button.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(loc.alreadyHaveAnAccountText),
        gapW4,
        CustomTextButton(
          onPressed: () => context.goNamed(
            AppRoute.signIn.name,
          ),
          text: loc.signInButtonTitle,
        )
      ],
    );
  }
}
